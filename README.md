# open source client communication module<3
- Send and receive data between roblox clients.
- No obvious/visible comunication method (chat, emotes, etc)
## make sure to star this repo if you like this!

# -- // ABOUT \\\ --

- each value can only handle -999999 to 999999 (i think, im guessing. u can try more though)

- this module was made to send information between clients without it being visible in chat
  
- released & developed by really_ant.

- yes my code is bad, deal w/ it!!

# -- // USAGE \\\ --

## explanations
```lua
local listener = loadstring(game:HttpGet('https://raw.githubusercontent.com/jj123llol/CloudEditCameraCoordinateFrame/refs/heads/main/src.lua', true))()

-- set resting channel.
listener.RestChannel(500) -- sets the users resting cframe to CFrame.new(500, 0, 0). Should be used at the start, right after defining the module.

-- start listening to channel
local channel = listener.Listen(1)

-- add functions to channel
local func = channel.AddFunction(function(Sender, num1, num2)
  print(Sender.Name, num1, num2)
end)

-- send message
channel.Send(number1, number2)

-- stopping one function in the channel
func.Disconnect()

-- stopping entire listening, disconnects all functions currently in the channel
channel.Unlisten()
```

## explanations 2/sending strings.
```lua
local listener = loadstring(game:HttpGet('https://raw.githubusercontent.com/jj123llol/CloudEditCameraCoordinateFrame/refs/heads/main/src.lua', true))()
local channel = listener.Listen(1)
local rid = -1 -- we will use this to make sure strings dont get sent twice.
local func = channel.AddFunction(function(Sender, num1, num2)
    if not (rid == num2) then -- make sure its not the same packet, avoids dupes
        print(Sender.Name, listener.DecodePacket(num1)) -- turns the numbers back into a string
        rid = num2
    end
end)

channel.SendString("Hello From twnvy!") -- this string will be split up and converted to numbers, each packet will be sent by its self.
```

## explanations 3/finding a channel a specific user cant access..
```lua
local listener = loadstring(game:HttpGet('https://raw.githubusercontent.com/jj123llol/CloudEditCameraCoordinateFrame/refs/heads/main/src.lua', true))()
local targets_Channel = listener.GetRestChannel(target plr instance)
local channel = listener.Listen(targets_Channel)
channel.SendString("hidden from the target")
```
    
# -- // WHY I MADE THIS \\\ --

I originally wanted to use Bug's animation socket to send client information
but if you rejoined and ran the script again, it would fire every previously sent message at the same time (unless the person who ran them reset)..


# -- // WHAT CAN I DO WITH THIS? \\\ --
- Command system, num1 is a command id num2 represents a player.
- Sending signals between players to execute functions, like reset or teleport to runner. 
