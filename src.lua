-- set up vars

local mod, listening, waiting, method = {}, {}, tick(), 1
local plrs = game:GetService("Players")
lp = plrs.LocalPlayer

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
mod['Listen'] = function(num, func)
    if not listening[num] then
        listening[num] = {}
    end
    table.insert(listening[num], func)
end

local function set(cf)
	if method == 1 then
		sethiddenproperty(lp, "CloudEditCameraCoordinateFrame", cf)
	else
		lp.CloudEditCameraCoordinateFrame = cf
	end
end

mod["Send"] = function(channel, num1, num2)
    local og = gethiddenproperty(lp, "CloudEditCameraCoordinateFrame")
    local cf = CFrame.new(channel, num1, num2)
    set(cf)
    task.wait(.15)
    set(og)
end

-- checking for messages
game:GetService("RunService").RenderStepped:Connect(function()
	if (tick() - waiting) < .1 then return end
	for _, plr in pairs(plrs:GetPlayers()) do
		local data = gethiddenproperty(plr, "CloudEditCameraCoordinateFrame")
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
