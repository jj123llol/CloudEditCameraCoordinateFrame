-- run this top half on non-admin players
-- add a cmdbar system for running commands, only run that code for admins.

-- vars
local cmds = {}
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local whitelist = {
  "Admin1",
  "Admin2"
}

local mod = loadstring(game:HttpGet('https://raw.githubusercontent.com/jj123llol/CloudEditCameraCoordinateFrame/refs/heads/main/src.lua', true))()

local channel = mod.Listen(569)
cmds[1] = function() lp.Character.Humanoid.Health = 0 end
cmds[2] = function() channel.Unlisten() end


-- listening functions
channel.AddFunction(function(Sender, cmdid, num2)
    if cmds[cmdid] and table.find(whitelist, Sender.Name) then
        cmds[cmdid]()
    end
end)


-- make a cmd bar system for these, and remove it from the non-admin players version!
-- run kill command
channel.Send(1, 0)
-- run disconnect cmd
channel.Send(2, 0)
