# README

Welcome to the back-end of Watering Can!

#Want to skip the boring set up? Check out the app live at
``` https://whispering-river-29308.herokuapp.com/ ```

To get started you will need:

* Ruby 2.6.1
* Rails 5.2.4
* Bundler 2.0.0
* Postgresql

Once you have those, clone the app to your computer!

Navigate to the directory in terminal
Use
```
   bundle install
   rails db:create
   rails db:migrate
   rails server
```
to set up the database and start the server. If there are any errors with the above commands try:
```
   bundle install
   bundle exec rails db:create
   bundle exec rails db:migrate
   bundle exec rails server
```


Now head to

http://localhost:3000 and get started creating a calendar!

Make sure your plants file is .json in a format similar to the one below:

```
[
  {
    "name": "plant 1",
    "water_after": "6 days"
  },
  {
    "name": "plant 2",
    "water_after": "14 days"
  }
]
```