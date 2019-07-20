json.body @message.body
json.image @message.image
json.user_name @message.user.name
json.create_date @message.created_at.strftime("%Y/%m/%d(%a) %H:%M:%S")
#idも渡す
json.id @message.id