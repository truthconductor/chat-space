json.array! @messages do |message|
  json.body message.body
  json.image message.image
  json.create_date message.created_at.strftime("%Y/%m/%d(%a) %H:%M:%S")
  json.user_name message.user.name
  json.id message.id
end