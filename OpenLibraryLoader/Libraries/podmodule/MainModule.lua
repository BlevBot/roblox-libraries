local module = {} -- Mode, TaggedPrint, Transpose, AddClass

local TestService = game:GetService('TestService')
local HttpService = game:GetService('HttpService')

module.Difference = function(Num1, Num2)
	assert(type(Num1) == 'number' and type(Num2) == 'number', 'Difference needs two numbers')
	if Num1 >= Num2 then
		return Num1 - Num2
	else
		return Num2 - Num1
	end
end

module.Compare = function(Num1, Num2)
	assert(type(Num1) == 'number' and type(Num2) == 'number', 'Compare needs two numbers')
	if Num1 == Num2 then
		return '='
	elseif Num1 > Num2 then
		return '>'
	elseif Num1 < Num2 then
		return '<'
	end
end

--module.Transpose = function(Matrix, Dimensions)                                                                                     [Unsure of what else to check for]
--	assert(type(Matrix) == 'table' and #Matrix > 0, 'Transpose needs a matrix')
--	assert(type(Dimensions) == 'nil' or type(Dimensions) == 'number', 'Transpose dimensions needs to be a number')
--	assert(Dimensions > 1, 'Transpose needs at least 2 dimensions')
--	local NewMatrix = {}
--	if Dimensions == nil then
--		Dimensions = 2
--	end
--	if Dimensions == 2 then
--		for i = 1, #Matrix do
--			for j,w in pairs(Matrix[i]) do
--				NewMatrix[j] = NewMatrix[j] or {}
--				NewMatrix[j][i] = w
--			end
--		end
--	end
--	if Dimensions == 3 then
--		for i = 1, #Matrix do
--			for k = 1, #Matrix[i] do
--				for j,w in pairs(Matrix[i][k]) do
--					NewMatrix[j] = NewMatrix[j] or {}
--					NewMatrix[j][k] = NewMatrix[j][k] or {}
--					NewMatrix[j][k][i] = w
--				end
--			end
--		end
--	end
--	return NewMatrix
--end

module.DotProduct = function(Table1, Table2)
	assert(type(Table1) == 'table' and type(Table2) == 'table', 'DotProduct needs two tables of numbers')
	assert(#Table1 == #Table2, 'DotProduct tables need to be the same length')
	local Result = nil
	local Products = {}
	for i = 1, #Table1 do
		assert(Table1[i] == 'number' and Table2[i] == 'number', 'DotProduct needs two tables of numbers')
		Products[i] = Table1[i] + Table2[i]
	end
	for i,v in pairs(Products) do
		Result = Result + v
	end
	return Result
end

module.Noise = function(X, Y, Z, Seed, Type, Amplitude, Frequency, Lacunarity, Octaves, Gain, TwirlFactor)
	assert(type(X) == 'number' or type(Y) == 'number' or type(Z) == 'number', 'Noise needs at least one coordinate')
	assert(type(Seed) == 'nil' or type(Seed) == 'number', 'Noise Seed needs to be a number')
	assert(type(Type) == 'nil' or Type == 'Perlin' or Type == 'Ridged', 'Noise Type can only be Perlin or Ridged')
	assert(type(Amplitude) == 'nil' or type(Amplitude) == 'number', 'Noise Amplitude needs to be a number')
	assert(type(Frequency) == 'nil' or type(Frequency) == 'number', 'Noise Frequency needs to be a number')
	assert(type(Lacunarity) == 'nil' or type(Lacunarity) == 'number', 'Noise Lacunarity needs to be a number')
	assert(type(Octaves) == 'nil' or type(Octaves) == 'number' and Octaves == math.ceil(Octaves), 'Noise Octaves needs to be an integer')
	assert(type(Gain) == 'nil' or type(Gain) == 'number', 'Noise Gain needs to be a number')
	assert(type(TwirlFactor) == 'nil' or type(TwirlFactor) == 'number', 'Noise TwirlFactor needs to be a number')
	local X2 = X or 1
	local Y2 = Y or 1
	local Z2 = Z or 1
	local Seed2 = Seed or 1
	local Type2 = Type or 'Perlin'
	local Amplitude2 = Amplitude or 4
	local Frequency2 = Frequency or 10
	local Lacunarity2 = Lacunarity or 2
	local Octaves2 = Octaves or 1
	local Gain2 = Gain or 2
	assert(Octaves2 >= 1, 'Noise Octaves must be at least 1')
	local TwirlFactor2 = TwirlFactor or 0
	local function FBM(x,y,z)
		local Height = 0
		local Amp = Amplitude2
		local Freq = Frequency2
		for i = 1, Octaves2 do
			Height = (Height + (Amplitude2 * math.noise((x + Seed2) / Frequency2, (y + Seed2) / Frequency2, (z+ Seed2) / Frequency2)))
			Freq = (Freq * Lacunarity2)
			Amp = (Amp * Gain2)
		end
		return Height
	end
	if Type2 == 'Perlin' then
		return FBM(X2 + TwirlFactor2 * FBM(X2,Y2,Z2), Y2 + TwirlFactor2 * FBM(X2,Y2,Z2), Z2 + TwirlFactor2 * FBM(X2,Y2,Z2))
	elseif Type2 == 'Ridged' then
		return -math.abs(FBM(X2 + TwirlFactor2 * FBM(X2,Y2,Z2), Y2 + TwirlFactor2 * FBM(X2,Y2,Z2), Z2 + TwirlFactor2 * FBM(X2,Y2,Z2))) * 2 + 1
	end
end

module.Factors = function(Num)
	assert(type(Num) == 'number', 'Factors needs a number')
	local NumFactors = {}
	local Index = 1
	while Index <= Num / 2 do
		if Num / Index == math.ceil(Num / Index) then
			NumFactors[#NumFactors + 1] = Index
		end
		Index = Index + 1
	end
	NumFactors[#NumFactors + 1] = Num
	return NumFactors
end

module.LCM = function(Num1, Num2)
	assert(type(Num1) == 'number' and type(Num2) == 'number', 'LCM needs two numbers')
	local Found = false
	local Index = 1
	local Result = nil
	while Found == false do
		if Num1 * Index / Num2 == math.ceil(Num1 * Index / Num2) then
			Result = Num1 * Index
			Found = true
		end
		Index = Index + 1
	end
	return Result
end

module.HCF = function(Num1, Num2)
	assert(type(Num1) == 'number' and type(Num2) == 'number', 'HCF needs two numbers')
	local Found = false
	local Index = math.min(Num1, Num2)
	local Result = nil
	while Found == false do
		if Num1 / Index == math.ceil(Num1 / Index) and Num2 / Index == math.ceil(Num2 / Index) then
			Result = Index
			Found = true
		end
		Index = Index + 1
	end
	return Result
end

module.Even = function(Num)
	assert(type(Num) == 'number', 'Even needs a number')
	if Num / 2 == math.ceil(Num / 2) then
		return true
	else
		return false
	end
end

module.Odd = function(Num)
	assert(type(Num) == 'number', 'Odd needs a number')
	if Num / 2 == math.ceil(Num / 2) then
		return false
	else
		return true
	end
end

module.Round = function(Num)
	assert(type(Num) == 'number', 'Round needs a number')
	local Result = math.floor(Num + 0.5)
	return Result
end

module.Min = function(Table)
	local Result = 0
	assert(type(Table) == 'table', 'Min needs a table of numbers')
	assert(#Table > 0, 'Min table needs at least one number')
	for i,v in pairs(Table) do
		assert(type(v) == 'number', 'Min table needs only numbers')
		if v < Result then
			Result = v
		end
	end
	return Result
end

module.Max = function(Table)
	local Result = 0
	assert(type(Table) == 'table', 'Max needs a table of numbers')
	assert(#Table > 0, 'Max table needs at least one number')
	for i,v in pairs(Table) do
		assert(type(v) == 'number', 'Max table needs only numbers')
		if v > Result then
			Result = v
		end
	end
	return Result
end

module.Average = function(Table)
	assert(type(Table) == 'table' and #Table > 0, 'Average needs a table of numbers')
	local Total = 0
	for i,v in pairs(Table) do
		assert(type(v) == 'number', 'Average needs a table of numbers')
		Total = Total + v
	end
	return Total / #Table
end

module.Mean = function(Table)
	assert(type(Table) == 'table' and #Table > 0, 'Mean needs a table of numbers')
	local Total = 0
	for i,v in pairs(Table) do
		assert(type(v) == 'number', 'Mean needs a table of numbers')
		Total = Total + v
	end
	return Total / #Table
end

module.Median = function(Table)
	assert(type(Table) == 'table' and #Table > 0, 'Median needs a table of numbers')
	for i,v in pairs(Table) do
		assert(type(v) == 'number', 'Median needs a table of numbers')
	end
	local Table2 = Table
	table.sort(Table2)
	if module.Even(#Table2) then
		return module.Average({Table2[#Table2 / 2], Table2[#Table2 / 2+ 1]})
	else
		return Table2[#Table2 / 2 + 0.5]
	end
end

---------------------------------------------------------------------------- Mode

module.Range = function(Table)
	assert(type(Table) == 'table' and #Table > 0, 'Range needs a table of numbers')
	for i,v in pairs(Table) do
		assert(type(v) == 'number', 'Range needs a table of numbers')
	end
	local Table2 = Table
	table.sort(Table2)
	return Table2[#Table2] - Table2[1]
end

module.Print = function(...)
	local Lines = {...}
	for i,v in pairs(Lines) do
		print(v)
	end
end

module.GetPrint = function(...)
	local Lines = {...}
	local Result = {}
	for i,v in pairs(Lines) do
		Result[#Result + 1] = v
	end
	return Result
end

--module.TaggedPrint = function(Tag, ...)
	--local Lines = module.GetPrint({...})[1]
	--Tag = Tag or ''
	--for i,v in pairs(Lines) do
		--if type(v) == 'table' then
			--error('Cannot print tagged tables')
		--else
			--warn(Tag..':      '..v)
		--end
	--end
--end

module.GetSiblings = function(Object)
	assert(typeof(Object) == 'Instance', 'GetSiblings Object must be an instance')
	local Result = Object.Parent:GetChildren() or {}
	for i,v in pairs(Result) do
		if v == Object then
			table.remove(Result, i)
		end
	end
	return Result
end

module.RGBToHex = function(Color)
	local RGBNumbers = {math.round(Color.R * 255), math.round(Color.G * 255), math.round(Color.B * 255)}
	local HexStrings = {}
	for i,v in pairs(RGBNumbers) do
		local Base = math.floor(v / 16)
		local Remainder = (v - (Base * 16))
		local Letters = {'F', 'E', 'D', 'C', 'B', 'A'}
		if Base >= 10 then
			Base = Letters[16 - Base]
		end
		if Remainder >= 10 then
			Remainder = Letters[16 - Remainder]
		end
		print(Base, Remainder)
		HexStrings[i] = Base..Remainder
		print(HexStrings[i])
	end	
	return table.concat(HexStrings)
end

--module.AddClass = function(Name, ...)
--	local Properties = {...}
--	local PropertyTable
--	for i,v in pairs(Properties) do
--		PropertyTable[v] = nil
--	end
--	local Class = {}
--	Class.__index = Class
--	local Return = setmetatable(PropertyTable, Class)
--	return Return
--end

local Embed = {}
Embed.__index = Embed

module.NewEmbed = function(Title, Description, Color, URL)
	assert(Title ~= nil, 'NewEmbed needs a Title')
	assert(typeof(Title) == 'string', 'NewEmbed Title must be a string')
	assert(Description == nil or typeof(Description) == 'string', 'NewEmbed Description must be a string')
	assert(URL == nil or typeof(URL) == 'string', 'NewEmbed URL must be a string')
	assert(Color == nil or typeof(Color) == 'Color3', 'NewEmbed Color must be a Color3')
	local Return = {}
	setmetatable(Return, Embed)
	Return.title = Title
	Return.description = Description
	Return.url = URL
	--Return.color = module.RGBToHex(Color)
	Return.thumbnail = {url = 'https://i.imgur.com/wSTFkRM.png'}
	local Time = os.date("!*t", os.time());
	Return.timestamp = string.format("%04d-%02d-%02dT%02d:%02d:%02dZ", Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec)
	Return.image = {url = 'https://i.imgur.com/wSTFkRM.png'}
	Return.footer = {text = 'footertext', icon_url = 'https://i.imgur.com/wSTFkRM.png'}
	Return.author = {name = 'author (google)', url = 'https://google.com', icon_url = 'https://i.imgur.com/wSTFkRM.png'}
	Return.fields = {}
	return Return
end

function Embed:AddField(Name, Value, Inline)
	assert(Name ~= nil, 'AddField needs a Name')
	assert(Value ~= nil, 'AddField needs a Value')
	assert(typeof(Name) == 'string', 'AddField Name must be a string')
	assert(typeof(Value) == 'string', 'AddField Value must be a string')
	assert(Inline == nil or typeof(Inline) == 'boolean', 'AddField Inline must be a boolean')
	for i,v in pairs(self.fields) do
		assert(v.name ~= Name, 'AddField Name already exists')
	end
	local Field = {}
	Field.name = Name
	Field.value = Value
	Field.inline = Inline or false
	table.insert(self.fields)
end

function Embed:RemoveField(Name)
	assert(Name ~= nil, 'RemoveField needs a Name')
	assert(typeof(Name) == 'string', 'RemoveField Name must be a string')
	local Found = false
	for i,v in pairs(self.fields) do
		if v.name == Name then
			Found = true
			table.remove(self.fields, i)
		end
	end
	assert(Found, 'RemoveField Name didn\'t exist')
end

function Embed:RemoveAllFields()
	self.fields = {}
end

function Embed:GetFields()
	return self.fields
end

local Webhook = {}
Webhook.__index = Webhook

module.NewWebhook = function(URL, Username)
	assert(typeof(URL) == 'string', 'NewWebhook URL must be a string')
	assert(Username == nil or typeof(Username) == 'string', 'NewWebhook Username must be a string')
	assert(string.sub(URL, 1, 33) == 'https://discord.com/api/webhooks/', 'NewWebhook URL must begin with \'https://discord.com/api/webhooks/\'')
	local Return = {}
	setmetatable(Return, Webhook)
	Return.URL = URL
	Return.Username = Username or ''
	return Return
end
	
function Webhook:SetUsername(Username)
	assert(Username ~= nil, 'SetUsername needs a string')
	assert(typeof(Username) == 'string', 'SetUsername Username must be a string')
	self.Username = Username
end
	
function Webhook:Message(Content, ...)
	local Embeds = {...}
	if self.Username == '' then
		local Success, Error = pcall(
			HttpService.PostAsync,
			HttpService,
			self.URL,
			HttpService:JSONEncode({content = Content, embeds = Embeds})
		)
		return(Error)
	else
		local Success, Error = pcall(
			HttpService.PostAsync,
			HttpService,
			self.URL,
			HttpService:JSONEncode({content = Content, embeds = Embeds, username = self.Username})
		)
		return(Error)
	end
end

module.Snap = function(Number, Points)
	assert(type(Number) == 'number', 'Snap Number must be a number')
	assert(type(Points) == 'table', 'Snap Points must be a table of number')
	assert(#Points > 0, 'Snap Points must have at least one number')
	local Closest = nil
	local Distance = nil
	for i,v in pairs(Points) do
		assert(type(v) == 'number', 'Snap Points must be a table of numbers')
		if Distance == nil or math.abs(Number - v) < Distance then
			Distance = math.abs(Number - v)
			Closest = v
		end
	end
	return Closest
end

module.Correlate = function(Number, Scale)
	assert(type(Number) == 'number', 'Correlate Number must be a number')
	assert(Number <= 1 and Number >= 0, 'Correlate Number must be between 0 and 1')
	assert(typeof(Scale) == 'NumberSequence', 'Correlate Scale must be a NumberSequence')
	if Number == 0 then
		return Scale.Keypoints[1].Value
	end
	if Number == 1 then
		return Scale.Keypoints[#Scale.Keypoints].Value
	end
	for i = 1, #Scale.Keypoints - 1 do
		local Current = Scale.Keypoints[i]
		local Next = Scale.Keypoints[i + 1]
		if Number >= Current.Time and Number < Next.Time then
			local Alpha = (Number - Current.Time) / (Next.Time - Current.Time)
			return (Next.Value - Current.Value) * Alpha + Current.Value
		end
	end
end

module.SameColour = function(ColorOne, ColorTwo)
	assert(typeof(ColorOne) == 'Color3', 'SameColour ColorOne must be a Color3')
	assert(typeof(ColorTwo) == 'Color3', 'SameColour ColorTwo must be a Color3')
	if math.abs(ColorOne.R - ColorTwo.R) > 0.001 or math.abs(ColorOne.G - ColorTwo.G) > 0.001 or math.abs(ColorOne.B - ColorTwo.B) > 0.001 then
		return false
	else
		return true
	end
end

return module
