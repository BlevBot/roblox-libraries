# Open Library Loader

*A Roblox package designed to manage and organise module imports and provide an open library index.*

OpenLibraryLoader can be used on both client and server to require

[Installation](https://github.com/BlevinsWasTaken/openlibraryloader/blob/main/README.md#Installation)

[Documentation](https://github.com/BlevinsWasTaken/openlibraryloader/blob/main/README.md#Documentation)

[Library Index](https://github.com/BlevinsWasTaken/openlibraryloader/blob/main/LibraryIndex.lua)

# Installation

- If you want it as simple as possible, require the most recent version of the module and run the return:
```
require(6423687833)()
```

- If you don't want red underlines in the editor for *install*, set *install* to the line above:
```
local install = require(6423687833)()
```

- If you want to easily inspect the source, insert (https://www.roblox.com/library/6423687833) into ReplicatedScriptService and require the MainModule:
```
require(game:GetService('ReplicatedScriptService').OpenLibraryLoader.MainModule)()
```

- If you're a power user and want the very latest commit, use [RepoToRoblox](https://devforum.roblox.com/t/1000272) to clone this repository into ReplicatedScriptService with trim filetype on.

# Documentation

**Functions**

---

- **require**

*Returns specified module or Library by reference or Key and inserts appropriate global variable into script.*

Arguments:

>Module \<Variant> : Either a reference to a module like the regular *require* function argument, or a *Key* used to store a module or require a *Library*.

>Alias \<string> : An optional name to reference the object by in the script, defaults to the *Key*.


- **install**

*Imports an owned module under a Key for either server-only or replicated use.*

Arguments:

>ID \<integer> : A model ID which contains a main module and is owned by the place owner.

>Key \<string> : The *Key* to be used later for requiring and referencing module.

>Replicated \<boolean> : Optional boolean deciding whether to allow client access to the installed module, defaults to true.
