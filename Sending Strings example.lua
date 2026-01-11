--[[
Shoutout the homie [twnvy @ Surplus Softworks] for this code example. U a real one :fire:
]]
(function(fkstring)
    local fkstring = fkstring or "Enter yo message here"

    local listener = loadstring(game:HttpGet('https://raw.githubusercontent.com/jj123llol/CloudEditCameraCoordinateFrame/refs/heads/main/src.lua', true))()

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

    local channel = listener.Listen(67)

    local rid = -1

    channel.AddFunction(function(Sender, num1, num2)
        if not (rid == num2) then
            print(Sender.Name, DeserializeChatFragment(num1))
            rid = num2
        end
    end)

    local Serialized = SerializeChatMessage(fkstring)
    for i,v in pairs(Serialized) do
        channel.Send(v, math.random(1,10000))
        task.wait(0.1)
    end
end)()
