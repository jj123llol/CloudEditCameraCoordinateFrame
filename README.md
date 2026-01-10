# -- // ABOUT \\\ --

- each value can only handle -999999 to 999999 (i think, im guessing. u can try more though)

- dont use 0 as a channel, it is a resting pos!

- this module was made to send information between clients without it being visible in chat
  
- released & developed by really_ant.

- yes my code is bad, deal w/ it!!


# -- // USAGE \\\ --
```lua
local mod = loadstring(game:HttpGet('https://raw.githubusercontent.com/jj123llol/CloudEditCameraCoordinateFrame/refs/heads/main/src.lua', true))()

-- start listening to channel
local channel = mod.Listen(1)

-- add functions to channel
local func = channel.AddFunction(function(num1, num2)
  print(num1, num2)
end)

-- send message
channel.Send(number1, number2)

-- stopping one function in the channel
func.Disconnect()

-- stopping entire listening, disconnects all functions currently in the channel
channel.Unlisten()
```
    
# -- // WHY I MADE THIS \\\ --

I originally wanted to use Bug's animation socket to send client information
but if you rejoined and ran the script again, it would fire every previously sent message at the same time (unless the person who ran them reset)..


# -- // WHAT CAN I DO WITH THIS? \\\ --
- Command system, num1 is a command id num2 represents a player.
- Sending signals between players to execute functions, like reset or teleport to runner. 
