-------------------------------------------------
-- Namespace
-------------------------------------------------
local _, ahs = ...
-------------------------------------------------
-- Testing area
-------------------------------------------------

-------------------------------------------------
-- Basic initialization
-------------------------------------------------
local function HandleSlashCommands(str)
    if (str == "scan") then
        ahs.core.scan:StartScan()
    end
    if (str == "test") then
        print(c())
    end
    if (str == "csv") then
        ahs.util.csv:DBTableToCSV(AHSDB, false)
    end
    if (str == "csvt") then
        ahs.csvThreadedFrame = CreateFrame("Frame")
        ahs.csvThreadedFrame:SetScript("OnUpdate", ahs.util.csv.DBTableToCSVThreaded)
    end
    if (str == "load") then
        for i = 1, GetNumAuctionItems("list") do 
            GetAuctionItemInfo("list", i)
        end
    end
end
-------------------------------------------------
-- Registering slash commands for 
-- dev QoL and core functionality 
-------------------------------------------------
SLASH_AHSCRAPE1 = "/ah"
SlashCmdList.AHSCRAPE = HandleSlashCommands
SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI

ahs.util.event:RegisterStartupEvents()
print("ahscrape.lua loaded")
