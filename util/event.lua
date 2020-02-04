-------------------------------------------------
-- Namespace
-------------------------------------------------
local _, ahs = ...
ahs.util = {}
ahs.util.event = {}
local E = ahs.util.event
-------------------------------------------------
-- Event handlers
-------------------------------------------------
-- If AH is open and GetAll off cooldown, queries all items.
local function AHOpenHandler()
    ahs.core.scan.isAhOpen = true
    if (select(2, CanSendAuctionQuery())) then
        print("AH window opened, querying GetAll scan")
        QueryAuctionItems(0, 0,0,0,0,0, true, 0, 0)
    else
        print("GetAll scan is currently on cooldown, please relog your character to query")
    end
end
-- Sets isAhOpen to false and prints message if value changed,
-- this is to throttle spam because the event fires twice.
local function AHClosedHandler()
    local oldstate = ahs.core.scan.isAhOpen
    ahs.core.scan.isAhOpen = false
    if oldstate then
        print("AH Closed")
    end
end
-------------------------------------------------
-- Control functions
-------------------------------------------------
function E:RegisterStartupEvents()
    E.eventFrame = CreateFrame("Frame")
    local eventFrame = E.eventFrame
    eventFrame:RegisterEvent("AUCTION_HOUSE_SHOW")
    eventFrame:RegisterEvent("AUCTION_HOUSE_CLOSED")
    eventFrame:RegisterEvent("ADDON_LOADED")
    eventFrame:SetScript("OnEvent", E.EventHandler)
end

function E:EventHandler(event, name, ...)
    if (event == "ADDON_LOADED" and name == "AHScrape") then
        print(name, "initialized")
    elseif event == "AUCTION_HOUSE_SHOW" then
        AHOpenHandler()
    elseif event == "AUCTION_HOUSE_CLOSED" then
        AHClosedHandler()
    end
end

print("event.lua loaded")
