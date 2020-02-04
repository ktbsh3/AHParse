-------------------------------------------------
-- Namespace
-------------------------------------------------
local _, ahs = ...
ahs.core = {}
-------------------------------------------------
-- Initializing scanner-specific
-- variables
-------------------------------------------------
ahs.core.scan = {}
local scan = ahs.core.scan
scan.isAhOpen = false
local i = 1
local num_of_ah_items
local scanner

local ahItem = {
    name = nil,
    texture = nil,
    count = nil,
    quality = nil,
    canUse = nil,
    level  = nil,
    levelColHeader = nil,
    minBid = nil,
    minIncrement = nil,
    buyoutPrice = nil,
    bidAmount = nil,
    highBidder = nil,
    bidderFullName = nil,
    owner = nil,
    ownerFullName = nil, 
    saleStatus = nil,
    itemId = nil,
    hasAllInfo = nil,
}

AHSDB = {}

function scan:readNextItem(...)
    for e = 1, 250 do 
        if (i > num_of_ah_items) then
            scanner:SetScript("OnUpdate", nil)
            print("DONE")
            return
        end
        local tbl = {GetAuctionItemInfo("list", i)}
        table.insert(AHSDB, tbl)
        print("At auction: ", i, "Of: ", num_of_ah_items)
        i = i+1
    end
end

function scan:StartScan()
    if scan.isAhOpen then
        print("Scanning the Auction House")
        i = 1
        AHSDB = {}
        AHSDB.Time = {date("%d/%m/%y %H:%M:%S")}
        num_of_ah_items = GetNumAuctionItems("list")
        scanner = CreateFrame("Frame")
        scanner:SetScript("OnUpdate", scan.readNextItem)
    else 
        print("Please open the AH window before scanning")
    end   

end


print("scan.lua loaded")
