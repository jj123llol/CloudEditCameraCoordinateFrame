# -- // ABOUT \\\ --

each value can only handle 1 - 999999 (i think, im guessing. u can try more th0ugh)

this module was made to send information between clients without it being visible in chat
released & developed by really_ant.
yes my code is bad, deal w/ it!!


# -- // USAGE \\\ --
```lua
local control = loadstring(game:HttpGet("https://raw.githubusercontent.com/jj123llol/CloudEditCameraCoordinateFrame/refs/heads/main/src.lua", true))()

-- listen for messages on channel 1
control.Listen(1, function(num1, num2) -- make sure to include num1 and num2, u can rename them to other names if u want
    print("got message:", num1, num2)
end)

-- send messages
control.Send(1, 6767, 80085)
```
    
# -- // WHY I MADE THIS \\\ --

I originally wanted to use Bug's animation socket to send client information
but if you rejoined and ran the script again, it would fire every previously sent message at the same time (unless the person who ran them reset)..


# -- // WHAT CAN I DO WITH THIS? \\\ --
- Command system, num1 is a command id num2 represents a player.
- Sending signals between players to execute functions, like reset or teleport to runner. 
