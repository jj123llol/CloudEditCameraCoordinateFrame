--[[

    THIS IS JUST A CONCEPT.
    
]]

local listener = loadstring(game:HttpGet('https://raw.githubusercontent.com/jj123llol/CloudEditCameraCoordinateFrame/refs/heads/main/src.lua', true))()
local channel = listener.Listen(50)
local rid = -1
local dString = ""

local function communication(sender, msg)
    print(sender.Name.." Said "..msg)
end

channel.AddFunction(function(Sender, num1, num2)
    if not (rid == num2) then
        local deserialized = listener.DecodePacket(num1)
        rid = num2
        if num2 == 0 then
            communication(Sender, dString)
            dString = ""
        else
            dString = dString .. deserialized
        end
    end
end)

channel.SendString("Hello From Plasmii")