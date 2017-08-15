local function run(msg, matches)
if is_sudo then
if matches[1] == 'ادخل' then
tg.importChatInviteLink('https://telegram.me/joinchat/'..matches[2])
elseif matches[1] == 'وضع اسم البوت' then
if matches[3] then
text = "تم تغير"..matches[2]..matches[3].." اسم البوت"
tg.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
tg.changeName(matches[2], matches[3])
else
text = "بالفعل تم تغير الاسم"..matches[2].." .. "
tg.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
tg.changeName(matches[2], '')
end
elseif matches[1] == 'وضع معرف البوت' then
tg.changeUsername(matches[2])
elseif matches[1] == 'حذف معرف البوت' then
tg.changeUsername('')
elseif matches[1] == 'وضع صوره البوت' then
tg.sendMessage(msg.chat_id_, 0, 1, 'رجاءا قم بارسال صوره لوضعها', 1, 'html')
redis:set('botphoto','yes')
elseif matches[1] == 'الصوره' and redis:get('botphoto') then
local file = 'bot/photos/bot.jpg'
print('File downloaded to:', msg.content_.photo_.sizes_[0].photo_.path_)
os.rename(msg.content_.photo_.sizes_[0].photo_.path_, file)
print('File moved to:', file)
tg.setProfilePhoto(msg.content_.photo_.sizes_[0].photo_.path_)
redis:del('botphoto',true)
end
if matches[1] == 'الماركداون' then
if matches[2] == 'on' then
text = '<b> تم وضع الماركداون => on</b>'
	tg.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
redis:set('markread','on')
elseif matches[2] == 'off' then
text = '<b> Mark Read => off</b>'
	tg.sendMessage(msg.chat_id_, 0, 1, text, 1, 'html')
redis:set('markread','off')
end
end
end
end
return {
  patterns = {
    "^(ادخل) https://telegram.me/joinchat/(.*)$",
	"^(وضع اسم البوت) (.*) (.*)$",
	"^(وضع اسم البوت) (.*)$",
	"^(وضع معرف البوت) (.*)$",
	"^(حذف معرف البوت)$",
	"^(وضع صوره البوت)$",
    "^(الماركداون) (.*)$",
	"^!!!edit:(الماركداون) (.*)$",
	"^(الصوره):$",
  },
  run = run
}