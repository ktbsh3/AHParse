-------------------------------------------------
-- Namespace
-------------------------------------------------
local _, ahs = ...
ahs.util.csv = {}
local csv = ahs.util.csv
-------------------------------------------------
-- Initializing csv-specific variables
-------------------------------------------------
AHSDB_csv = " "
AHSDB_serialized = {}
csv.csvkey = "id,name,texture,count,quality,canUse,level,levelColHeader,minBid,minIncrement,buyoutPrice,bidAmount,highBidder,bidderFullName,owner,ownerFullName,saleStatus,itemId,hasAllInfo"
-------------------------------------------------
-- Functions
-------------------------------------------------
--[[
function csv:DBTableToCSV(tbl, threaded)
    local frameskip = 100
    local frame = 1
    local len0 = #tbl
    local i = 1    
    local result = csv.csvkey
    for i = 1, len0 do 
        if threaded then 
            print("CSV processing: "..i.." of: "..len0)
        end
        local len1 = #tbl[i]
        result = result.."\n"
        for e = 1, len1 do
            val = tbl[i][e]
            if type(val == "boolean") then
                result = result..tostring(val)..","
            elseif (val == nil) then
                result = result.."nil"..","
            else
                result = result..val..","
            end
        end
        if (threaded and frame % frameskip == 0) then
            coroutine.yield()
        end
        frame = frame + 1
    end
    AHSDB_csv = result
    print("CSV var successfully created, please reload to refresh file")
    if threaded then
        ahs.csvThreadedFrame:SetScript("OnUpdate", nil)
    end
end
coro = coroutine.wrap(csv.DBTableToCSV)
function csv.DBTableToCSVThreaded()
    coro(nil, AHSDB, true)
end
]]

function csv:serialize(tbl)
    AHSDB_csv = {}
    AHSDB_serialized = {csv.csvkey}
    local i = 1
    for _, v in ipairs(tbl) do
        local result = i..","
        print (i)
        for e = 1, 18 do
            local val = v[e]
            if type(val == "boolean") then
                result = result..tostring(val)..","
            elseif (val == nil) then
                result = result.."nil"..","
            else
                result = result..val..","
            end
        end
        result = result:sub(1, #result-1)
        table.insert(AHSDB_serialized, result)
        i = i+1
        if (i % 100 == 0) then
            coroutine.yield()
        end
    end
    AHSDB_csv = table.concat(AHSDB_serialized, "#")
    ahs.csvThreadedFrame:SetScript("OnUpdate",   nil)
end

coro = coroutine.wrap(csv.serialize)
function csv:DBTableToCSVThreaded()
    coro(nil, AHSDB)
end