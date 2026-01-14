-- Sending strings by twnvy @ Surplus Softworks, he told me to add it.


--- set up vars.
type Callback = () -> ()
type sethiddenproperty = (Instance, string, any) -> ()
type setscriptable = (Instance, string, boolean) -> ()
type gethiddenproperty  = (Instance, string) -> (any)
if CloudEditCameraCoordinateFrameSocket then error("CloudEditCameraCoordinateFrameSocket Already running!") end

getgenv().CloudEditCameraCoordinateFrameSocket = true
local mod, listening, waiting, method, resting = {}, {}, tick(), 1, 0
local plrs = game:GetService("Players")
lp = plrs.LocalPlayer

-- can u even use ts :sob:
local passed = pcall(function()
	sethiddenproperty(lp, "CloudEditCameraCoordinateFrame", CFrame.new(0, 999, 999))
end)

local passed1, theerror

if not passed then 
	method = 2
	passed1, theerror = pcall(function()
		setscriptable(lp, "CloudEditCameraCoordinateFrame", true)
		lp.CloudEditCameraCoordinateFrame = CFrame.new(0, 999, 999)
	end)
end

if not passed and not passed1 then
	print("Not supported, cant setproperty")
	print("Error:", theerror)
	return nil
else
	print("part1 Supported")
	print("using method:", method)
end

local mappings = {
    ["a"] = 11,
    ["b"] = 12,
    ["c"] = 13,
    ["d"] = 14,
    ["e"] = 15,
    ["f"] = 16,
    ["g"] = 17,
    ["h"] = 18,
    ["i"] = 19,
    ["j"] = 20,
    ["k"] = 21,
    ["l"] = 22,
    ["m"] = 23,
    ["n"] = 24,
    ["o"] = 25,
    ["p"] = 26,
    ["q"] = 27,
    ["r"] = 28,
    ["s"] = 29,
    ["t"] = 30,
    ["u"] = 31,
    ["v"] = 32,
    ["w"] = 33,
    ["x"] = 34,
    ["y"] = 35,
    ["z"] = 36,
    ["A"] = 37,
    ["B"] = 38,
    ["C"] = 39,
    ["D"] = 40,
    ["E"] = 41,
    ["F"] = 42,
    ["G"] = 43,
    ["H"] = 44,
    ["I"] = 45,
    ["J"] = 46,
    ["K"] = 47,
    ["L"] = 48,
    ["M"] = 49,
    ["N"] = 50,
    ["O"] = 51,
    ["P"] = 52,
    ["Q"] = 53,
    ["R"] = 54,
    ["S"] = 55,
    ["T"] = 56,
    ["U"] = 57,
    ["V"] = 58,
    ["W"] = 59,
    ["X"] = 60,
    ["Y"] = 61,
    ["Z"] = 62,
    [" "] = 63,
    ["."] = 64,
    [","] = 65,
    ["!"] = 66,
    ["?"] = 67,
    ["'"] = 68,
    ['"'] = 69,
    ["-"] = 70,
    ["_"] = 71,
    [":"] = 72,
    [";"] = 73,
    ["("] = 74,
    [")"] = 75,
    ["@"] = 76,
    ["#"] = 77,
    ["$"] = 78,
    ["%"] = 79,
    ["^"] = 80,
    ["&"] = 81,
    ["*"] = 82,
    ["+"] = 83,
    ["="] = 84,
    ["/"] = 85,
    ["\\"] = 86,
    ["<"] = 87,
    [">"] = 88,
    ["~"] = 89,
    ["`"] = 90,
    ["0"] = 91,
    ["1"] = 92,
    ["2"] = 93,
    ["3"] = 94,
    ["4"] = 95,
    ["5"] = 96,
    ["6"] = 97,
    ["7"] = 98,
    ["8"] = 99,
    ["9"] = 10
}


local reverseMappings = {}
for char, val in pairs(mappings) do
    reverseMappings[val] = char
end

function SerializeChatMessage(message)
    local out = {}
    local chunk = {}
    for ch in tostring(message):gmatch(".") do
        table.insert(chunk, ch)
        if #chunk >= 2 then
            local n = ""
            for _, c in ipairs(chunk) do
                local code = mappings[c] or mappings[" "]
                n = n .. tostring(code)
            end
            out[#out + 1] = tonumber(n)
            chunk = {}
        end
    end
    if #chunk > 0 then
        local n = ""
        for _, c in ipairs(chunk) do
            local code = mappings[c] or mappings[" "]
            n = n .. tostring(code)
        end
        out[#out + 1] = tonumber(n)
    end

    return out
end

function DeserializeChatFragment(fragment)
    local frag = {}
    for c in tostring(fragment):gmatch("%d") do
        table.insert(frag, c)
    end

    local message = ""
    local i = 1

    while i <= #frag - 1 do
        local ch = (tonumber(frag[i]) * 10) + tonumber(frag[i + 1])
        local dec = reverseMappings[ch]
        message = message .. dec
        i = i + 2
    end

    return message
end

-- module functions

mod["cloudcf"] = {}
mod.cloudcf["set"] = function(cf : CFrame)
	if method == 1 then
		sethiddenproperty(lp, "CloudEditCameraCoordinateFrame", cf)
    elseif method == 2 then
		lp.CloudEditCameraCoordinateFrame = cf
	end
end

mod.cloudcf["get"] = function(plr : Player)
    plr = plr or lp
	if method == 1 then
		return gethiddenproperty(plr, "CloudEditCameraCoordinateFrame")
    end
	return plr.CloudEditCameraCoordinateFrame -- new method
end

mod['RestChannel'] = function(channel : number, optional1: number, optional2: number)
    channel, optional1, optional2 = channel or 0, optional1 or 0, optional2 or 0
    if listening[channel] then error("Cant set resting channel to a channel you are listening to!") end
    resting = channel
    mod.cloudcf["set"](CFrame.new(channel, optional1, optional2))
end

mod["DecodePacket"] = function(packet: number)
    return DeserializeChatFragment(packet)
end

mod["GetRestChannel"] = function(plr: Player)
    return mod["cloudcf"]["get"](plr).X -- if they send a message into a channel right at the same time this will break..
end

mod["SetDelay"] = function(del: number)
	delay = del
end

mod['Listen'] = function(channel : number)
    if channel == resting then error("Cant listen to resting channel!") end
    if not listening[channel] then
        listening[channel] = {}
    end
    local listenmod = {}

    listenmod['Unlisten'] = function()
        table.remove(listening, channel)
    end

    listenmod['AddFunction'] = function(func : Callback)
        local funcmod = {}
        table.insert(listening[channel], func)

        funcmod['Disconnect'] = function()
            table.remove(listening[channel], table.find(listening[channel], func))
        end
        return funcmod
    end

    listenmod["Send"] = function(num1 : number, num2 : number)
		num1, num2 = num1 or 30, num2 or 30
        local og = mod["cloudcf"]["get"](lp)
        local cf = CFrame.new(channel, num1, num2)
        mod.cloudcf["set"](cf)
		task.wait(.1)
        mod.cloudcf["set"](og)
    end

	listenmod["SendString"] = function(msg: string)
        local Serialized = SerializeChatMessage(msg)
        for i,v in pairs(Serialized) do
            local packetnum = i == #Serialized and 0 or math.random(1,10000)
            listenmod.Send(v, packetnum)
            task.wait(0.1)
        end
	end
    return listenmod
end

-- checking for messages, thanks for the updated one nathan
function onJoin(plr)
    plr.Changed:Connect(function(p)
        if p == "CloudEditCameraCoordinateFrame" then
		    local data = mod["cloudcf"]['get'](plr)
            if listening[data.X] then
                for _, func in pairs(listening[data.X]) do
                    func(plr, data.Y, data.Z)
                end
            end
        end
    end)
end 

for _, plr in pairs(plrs:GetPlayers()) do
    onJoin(plr)
end

plrs.PlayerAdded:Connect(onJoin)

-- enjoy<3

return mod
