local extraChar = require("mods/scripts/ExtraCharModule")

function onCreatePost()
    extraChar.makeCharacter("sigmas3","gary", "", false, {-400, 20}, "-alt")
    extraChar.makeCharacter("sigmas4","bf-crud", "", true, {1000, 100}, "-alt")
end