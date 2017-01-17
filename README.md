[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
Get your own Troop Website for free w/ Heroku

I am currently running my troop off this software utilizing the free pricing tiers of Heroku, Mailgun, NewRelic and Papertrail. The only costs I have incurred are with AWS S3 for file storage (last months bill was 28 cents).
##Configure for your troop
Edit the my_troop.yml file or set the ENV variable TROOP_CONFIG_FILE to point to your yml file


##User Roles
###Scout
 
 - View their Scout Record
 - View articles
 - View Calendar
 - Sign up for upcomming events
 
### Parent

 - View Scout/Scouts associated with them
 - View articles
 - View Calendar
 - Sign up their Scout(s) for upcoming event
 - Sign up themselves for upcoming event
 
### Leader

 - View all Scout
 - View All Adult
 - View Scouts by Patrol
 - View Scouts by Position
 - View Scouts by Rank
 - View Scouts by Training
 - Report for all Scouts
 - Create Articles
 - Essentially a read-only version of Leader_Full
 
### Leader Full

 - Add Scouts
 - View all Scout
 - View All Adult
 - View Scouts by Patrol
 - View Scouts by Position
 - View Scouts by Rank
 - View Scouts by Training
 - Add Patrols
 - Assign Scouts to Patrols
 - Manage Scout Positions
 - Manage Adult Positions
 - Create Articles
 - Create Events
 - Log Scout as attended Events
 - Log Adults as attended Events
 - Log Rank Requirement as Complete
 - Log Merit Badges Earned
 - Log Training taken
 - Log Awards Earned
 - Create New Awards
 - Run Reports
 - Add Vehicles
 - Associate Vehicle to Adult
 - Associate Parent to Scout
 - Set Notifications
 - Create Article Categories
 - Reports
 
### Admin
 - Link Users to Adult Records
 - Upload Files for Import
 - Import Records from Troopmaster
 - Add new Positions
 
 
## Environmental Variables

 - TROOP_CONFIG_FILE - specify a different yml file that holds troop information
 - WEBSITE_URL - URL of your troops website 
 - DEVISE_SECRET_KEY - This is the "salt" used to encrypt your password. Highly suggest that you set this as the default is viewable in the code  

 - EMAIL_FROM_ADDRESS - email address that outgoing mail will use

####Mailgun has a great free tier so we use them to send outgoing email
 - MAILGUN_API_KEY 
 - MAILGUN_DOMAIN
 - MAILGUN_PUBLIC_KEY
 - MAILGUN_SMTP_LOGIN
 - MAILGUN_SMTP_PASSWORD
 - MAILGUN_SMTP_PORT
 - MAILGUN_SMTP

 - GOOGLE_MAPS_API_KEY - Sign up with google for an api key, free tier works great

####AWS S3 is used to store files you upload for import
 - AWS_ACCESS_KEY_ID 
 - AWS_SECRET_ACCESS_KEY
 - AWS_REGION
 - S3_BUCKET_NAME

