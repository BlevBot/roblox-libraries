# Open Library Loader

*A Roblox module designed to manage and organise imports and provide an open package index.*



[Libraries](https://github.com/BlevinsWasTaken/openlibraryloader/blob/main/OpenLibraryLoader.lua/BuiltInLibraries.lua)

[Documentation](https://github.com/BlevinsWasTaken/openlibraryloader/blob/main/README.md#Documentation)


# Documentation

**Functions**

---

- **require**

*Returns specified module by reference or Key and inserts appropriate global variable into script.*

Arguments:

>Module \<Variant> : Either a reference to a module like the regular *require* function argument, or a *Key* used to store a module including a *BuiltInModule*.

>Alias \<string> : An optional name to reference the object by in the script, defaults to the *Key*.


- **install**

*Imports an owned module under a Key for either server-only or replicated use.*

Arguments:

>ID \<integer> : A model ID which contains a main module and is owned by the place owner.

>Key \<string> : The *Key* to be used later for requiring and referencing module.

>Replicated \<boolean> : Optional boolean deciding whether to allow client access to the installed module, defaults to true.
