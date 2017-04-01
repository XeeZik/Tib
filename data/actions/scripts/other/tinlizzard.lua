function onUse(cid, item, fromPosition, itemEx, toPosition)
  if item.itemid == 13292 and itemEx.itemid == 13306 then
  doSendMagicEffect(fromPosition, CONST_ME_MAGIC_BLUE)
  doPlayerAddMount(cid, 8)
doRemoveItem(item.uid, 1)
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Tin Lizzard ativado com sucesso!")
  else
  doSendMagicEffect(toPosition, CONST_ME_POFF)
end
 end