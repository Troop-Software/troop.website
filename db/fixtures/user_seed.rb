
User.seed(username:'Bob Koertge', email:'bob@bobkoertge.com', password:'123456')
Assignment.seed(user_id: 1, role_id: 1)
Assignment.seed(user_id: 1, role_id: 2)
Assignment.seed(user_id: 1, role_id: 3)
Assignment.seed(user_id: 1, role_id: 4)
Assignment.seed(user_id: 1, role_id: 5)

User.seed(username:'Bob Koertge', email:'bob2@bobkoertge.com', password:'123456')
Assignment.seed(user_id:2, role_id:3)
Relationship.seed(scout_id: 1, user_id: 2)

User.seed(username:'Bob Koertge', email:'bob3@bobkoertge.com', password:'123456')
Assignment.seed(user_id:3, role_id:3)
Relationship.seed(scout_id: 2, user_id: 3)
Relationship.seed(scout_id: 3, user_id: 3)
Relationship.seed(scout_id: 4, user_id: 3)
