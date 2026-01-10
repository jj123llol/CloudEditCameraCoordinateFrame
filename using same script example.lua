--[[

  This example lets people using your script know a fellow user is in the game.

  Hope this is useful to some developers who are new to scripting, but want to implement something like this into their script easily.

]]
local number1, number2 = (ur number here), (ur number here)

local mod = loadstring(game:HttpGet('https://raw.githubusercontent.com/jj123llol/CloudEditCameraCoordinateFrame/refs/heads/main/src.lua', true))()
local known_users = {}
--- pick a special channel
local channel = mod.Listen(6348)
local func = channel.AddFunction(function(Sender, num1, num2)
    if table.find(known_users, Sender.Name) then return end -- ignore users who are already labeled as using the same script
    --if num1 ~= number1 or num2 ~= number2 then return end -- (OPTIONAL, FOR DOUBLE CHECKING USER.)
    print(Sender.Name.." is using the same script as you!") -- replace this with a notification system if you wish
    table.insert(known_users, Sender.Name) -- make sure they dont get notified about the same user.
end)

-- you can use any type of loop, but for simple sake lets just use a while wait.

while task.wait(1) do
    channel.Send(number1, number2)
end
