 function onUse(cid, item, fromPosition, itemEx, toPosition)
  if item.itemid == 13938 and itemEx.itemid == 13937 then
  doSendMagicEffect(fromPosition, CONST_ME_MAGIC_BLUE)
  doPlayerAddMount(cid, 15)
doRemoveItem(item.uid, 1)
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Inoperative Uniwheel ativado com sucesso!")
  else
  doSendMagicEffect(toPosition, CONST_ME_POFF)
end
 end