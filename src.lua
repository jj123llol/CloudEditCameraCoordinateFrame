--- set up vars.

local mod, listening, waiting, method = {}, {}, tick(), 1
local plrs = game:GetService("Players")
lp = plrs.LocalPlayer


-- can u even use control :sob:
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
	print("control not supported, cant setproperty")
	print("Error:", theerror)
	return
else
	print("control part1 Supported")
	print("using method:", method)
end

local passed2, theerror = pcall(function()
	if gethiddenproperty(lp, "CloudEditCameraCoordinateFrame") ~= CFrame.new(0, 999, 999) then
		error("failed property")
	end
end)

if not passed2 then
	print("control not supported, can't readproperty")
	print("Error:", theerror)
	return
else
	print("Supported")
end


-- module functions

local function set(cf : CFrame)
	if method == 1 then
		sethiddenproperty(lp, "CloudEditCameraCoordinateFrame", cf)
    elseif method == 2 then
		lp.CloudEditCameraCoordinateFrame = cf
	end
end

mod['Listen'] = function(channel : number)
    if not listening[channel] then
        listening[channel] = {}
    end
    local listenmod = {}

    listenmod['Unlisten'] = function()
        table.remove(listening, channel)
    end

    listenmod['AddFunction'] = function(func : func)
        local funcmod = {}
        table.insert(listening[channel], func)

        funcmod['Disconnect'] = function()
            table.remove(listening[channel], table.find(listening[channel], func))
        end
        return funcmod
    end

    listenmod["Send"] = function(num1 : number, num2 : number)
        local og = gethiddenproperty(lp, "CloudEditCameraCoordinateFrame")
        local cf = CFrame.new(channel, num1, num2)
        set(cf)
        task.wait(.3)
        set(og)
    end

    return listenmod
end

-- checking for messages
game:GetService("RunService").RenderStepped:Connect(function()
	if (tick() - waiting) < .1 then return end
	for _, plr in pairs(plrs:GetPlayers()) do
		local data = gethiddenproperty(plr, "CloudEditCameraCoordinateFrame")
		print(data)
        if listening[data.X] then
            for _, func in pairs(listening[data.X]) do
                func(data.Y, data.Z)
            end
        end
	end
    waiting = tick()
end)


-- enjoy<3

return mod
