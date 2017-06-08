set print pretty on
set pagination off

gdb -p $(pidof Xorg)
(inside gdb)
set logging overwrite on
set logging on
break xorg_backtrace 

p xxx:xx

print *RecPtr
print RecPtr->tt
print RecPtr->a


 p *PickKeyboard::client->clientIds
 p *PickKeyboard::client->clientPtr->name
 
 display *PickKeyboard::client
 
 delete 2
 
 watch PickKeyboard::client->clientPtr
 
 
break DRI2SwapComplete
commands
  p DRI2SwapComplete::client->clientPtr
  continue
end

break PickKeyboard
commands
  p PickKeyboard::client->clientPtr
  continue
end



info b
