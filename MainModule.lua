local RepStorage = game:GetService('ReplicatedStorage')
local SSService = game:GetService('ServerScriptService')
local RunService = game:GetService('RunService')
local InsertService = game:GetService('InsertService')

local Env = getfenv(1)
local getModule = Env['require']

local RepFolder = nil
local Folder = nil
local LibraryIndex = getModule(script.Parent.LibraryIndex)

if not RepStorage:FindFirstChild('Modules') then
	RepFolder = Instance.new('Folder')
	RepFolder.Name = 'Modules'
	RepFolder.Parent = RepStorage
end
if not SSService:FindFirstChild('Modules') then
	Folder = Instance.new('Folder')
	Folder.Name = 'Modules'
	Folder.Parent = SSService
end

RepFolder = RepStorage:FindFirstChild('Modules')
Folder = SSService:FindFirstChild('Modules')

function install(ID, Key, Replicated)
	assert(RunService:IsServer(), 'Install cannot be called on a client')
	assert(type(ID) == 'number' and ID == math.ceil(ID), 'Install ID must be an integer')
	local Module = nil
	local Success, Error = pcall(function()
		Module = InsertService:LoadAsset(ID)
	end)
	assert(Success or Error ~= 'HTTP 404 (Not Found)', 'Install ID must be a module\'s ID')
	assert(Success or Error ~= 'HTTP 403 (Forbidden)', 'Install module must be owned')
	assert(Success or Error ~= 'HttpError: DnsResolve', 'Install failed due to a connection error, retry install')
	if not Success then
		print(Error)
		error('Unchecked error, contact OpenLibraryLoader developer')
	end
	assert(Module:FindFirstChild('MainModule'), 'Install model must include MainModule')
	assert(type(Key) == 'string', 'Install Key must be a string')
	local FinalKey = string.lower(Key)
	assert(not RepFolder:FindFirstChild(FinalKey) and not Folder:FindFirstChild(FinalKey) and not LibraryIndex[FinalKey], 'Install Key is already filled')
	local ScriptEnv = getfenv(2)
	assert(not ScriptEnv[Key], 'Install Key overlaps global, use Require As to replace')
	assert(Replicated == nil or type(Replicated) == 'boolean', 'Install Replicated must be a boolean')
	
	Module.Name = FinalKey
	for i,v in pairs(Module:GetChildren()) do
		if v.ClassName == 'Script' or v.ClassName == 'LocalScript' then
			v.Disabled = true
		end
	end
	if Replicated == false then
		Module.Parent = Folder
	else
		Module.Parent = RepFolder
	end
end

function require(Module, Alias)
	assert(type(Module) == 'string' or type(Module) == 'number' or (typeof(Module) == 'Instance' and Module.ClassName == 'ModuleScript'), 'Require must include a module or a Key')
	assert(Alias == nil or type(Alias) == 'string', 'Require Alias must be a string')
	assert(Alias ~= nil or type(Module) == 'number', 'Require must include Alias when Module is by ID')
	assert(Alias ~= nil or typeof(Module) == 'Instance', 'Require must include Alias when Module is by Instance')
	if Alias == nil then
		Alias = Module
	end
	local ScriptEnv = getfenv(2)
	if type(Module) == 'string' then
		local Module = RepFolder:FindFirstChild(Module).MainModule or Folder:FindFirstChild(Module).MainModule or nil
		assert(Module ~= nil or LibraryIndex[Module], 'Require cannot get Library on client')
		if Module == nil and LibraryIndex[Module] then
			Module = LibraryIndex[Module]
		end
		assert(Module ~= nil, 'Require Module Key does not exist')
		local OldEnv = getfenv(1)
		Module = getModule(Module)
		if OldEnv ~= getfenv(1) then
			ScriptEnv = getfenv(1)
			Env = OldEnv
		end
		ScriptEnv[Alias] = Module
		return Module
	elseif type(Module) == 'number' then
		assert(RunService:IsServer(), 'Require cannot get module by ID on a client')
		assert(Module == math.ceil(Module), 'Require module ID must be an integer')
		local Module = nil
		local OldEnv = getfenv(1)
		local Success, Error = pcall(function()
			Module = getModule(Module)
		end)
		assert(Success or not string.find(Error, 'Is the asset id correct and is the asset type "Model"?'), 'Require Module ID does not exist')
		if not Success then
			print(Error)
			error('Unchecked error, contact OpenLibraryLoader developer')
		end
		if OldEnv ~= getfenv(1) then
			ScriptEnv = getfenv(1)
			Env = OldEnv
		end
		ScriptEnv[Alias] = Module
		return Module
	elseif typeof(Module) == 'Instance' then
		local OldEnv = getfenv(1)
		local Module = getModule(Module)
		if OldEnv ~= getfenv(1) then
			ScriptEnv = getfenv(1)
			Env = OldEnv
		end
		ScriptEnv[Alias] = Module
		return Module
	end
end

local function setup()
	local ScriptEnv = getfenv(2)
	ScriptEnv['install'] = install
	ScriptEnv['require'] = require
	return install
end

return setup
