--------------------------------------------------------------------------
-------------=[ SinBot: Seven Deadly Sins Automator ]=--------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Credit to Palbot & Swar-X for implementation and structure inspiration.

-- Basic Configuration
localPath = scriptPath();
getNewestVersion = loadstring(httpGet("https://raw.githubusercontent.com/JoshingNotJoking/SinBot/master/lib/setup/version.lua"));
latestVersion = getNewestVersion();
currentVersion = dofile(localPath .. "/lib/setup/version.lua");
imgPath = localPath .. "images/1280x720"
setImagePath(imgPath);

-- Load user prompts
dofile(localPath .. "lib/dialogs/gui.lua");

-- Check if there are updates to the script
function automaticUpdates ()
  if currentVersion == latestVersion then
    toast ("SinBot is up to date!");
  else
    updatePrompt();
    if choice == 1 then -- GUI for gear farming
        dofile(localPath .. "setup.lua");
    else
        toast ("You'll be reminded to update on next launch.")
    end
  end
end

automaticUpdates ();

-- Load helpers & functions (This may be expensive for the interpreter, refactor later)
dofile(localPath .. "lib/regions.lua");
dofile(localPath .. "lib/gearFarm.lua");
dofile(localPath .. "lib/gearSalvage.lua");

-- Ask what user wants to do this session
introPrompt ();

if gearSelection == 1 then gearSelection = "gearAttack"
elseif gearSelection == 2 then gearSelection = "gearDefense"
elseif gearSelection == 3 then gearSelection = "gearHealth"
elseif gearSelection == 4 then gearSelection = "gearCrit"
elseif gearSelection == 5 then gearSelection = "gearCritRes"
elseif gearSelection == 6 then gearSelection = "gearRecovery"
end

if session == 1 then
  while true do
    gearFarm ();
    -- Clear inventory to continue farming
    if areaInventoryPrompt:exists(Pattern("areaInventoryPrompt.png")) then
      toast ("Equipment inventory full!");
      if gearCommon == true or gearUncommon == true or gearRare == true or gearSuperRare == true then
        gearSalvage();
      else
        scriptExit("Equipment inventory full!");
      end
    end
  end
end
