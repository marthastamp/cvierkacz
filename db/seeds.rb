message_1 = Message.create(content: 'Message content 1', author: 'John One')
message_2 = Message.create(content: 'Message content 2', author: 'John Two')
message_3 = Message.create(content: 'Message content 3', author: 'John Three')
message_4 = Message.create(content: 'Message content 4', author: 'John Four')
message_5 = Message.create(content: 'Message content 5', author: 'John Five')

Comment.create(content: 'Cool comment 1', author: 'Jane One', message: message_1)
Comment.create(content: 'Cool comment 2', author: 'Jane Two', message: message_2)
Comment.create(content: 'Cool comment 3', author: 'Jane Three', message: message_3)
Comment.create(content: 'Cool comment 4', author: 'Jane Four', message: message_4)
Comment.create(content: 'Cool comment 5', author: 'Jane Five', message: message_5)