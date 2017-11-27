# note-reminder

**Task:** write api for sign up, sign in and send note with push notifications for IOS devices.

Demo: https://intense-river-43264.herokuapp.com

**Launched on:**
- Ubuntu 16.04
- Ruby version: 2.4.2
- Rails version: 5.1.4
- PostgreSQL: 10.1
- Redis: 3.0.6

## How to play in localhost:

1. clone repository
    > git clone https://github.com/alexhifer/note-reminder.git
2. installing gems
    > bundle install
3. create role for PostgreSQL
    ```bash
    sudo -u postgres psql
    create role note_reminder with createdb login password '123456';
    \q 
4. Configure /config/database.yml like this
   ```yaml
   development:
     database: note_reminder_dev
     adapter: postgresql
     encoding: unicode
     pool: 5
     username: note_reminder
     password: 123456
     host: localhost
     port: 5432
5. Configure /config/grocer.yml
6. Create databases
   > rake db:create
7. Migrate the database
   > rake db:migrate
8. Loads the seed data
   > rake db:seed
9. Start web server
   > rails s
10. Start sidekiq
   > sidekiq
11. Open admin zone in browser (login: note_reminder@example.com, password: qwerty123)
   > http://localhost:3000/admin
   
## API Documentation

The query parameters can be HTTP or JSON

**User registration**

##### HTTP Request
> POST http://localhost:3000/api/v1/sign_up

##### Query Parameters
| Param | Type | Required | Description |
| --- | --- | --- | --- |
| email | string(5...255) | yes | User e-mail address |
| password | string(6...128) | yes | User password |
| device_token | string(1...255) | yes | Mobile device token for send push notifications |
| device_type | string, (ios, android), default(ios) | no | Type of device |

##### Request example
```bash
curl --data "email=test@example.com&password=qwerty123&&device_token=testtoken123" http://localhost:3000/api/v1/sign_up
```

##### Success response
```json
{
  "status": "success",
  "data": {
    "id": 1,
    "email": "test@example.com"
  }
}
```
##### Error response
```json
{
  "status": "error",
  "error_messages": {
    "email": ["has already been taken"]
  }
}
```

**User login**

##### HTTP Request
> POST http://localhost:3000/api/v1/sign_in

##### Query Parameters
| Param | Type| Required | Description |
| --- | --- | --- | --- |
| email | string(5...255) | yes | User e-mail address |
| password | string(6...128) | yes | User password |

##### Request example
```bash
curl --data "email=test@example.com&password=qwerty123" http://localhost:3000/api/v1/sign_in
```
##### Success response
```json
{
  "status": "success",
  "data": {
    "user_token": "CQFJgyPTLkszmsyr_dBD"
  }
}
```
##### Error response
```json
{
  "status": "error",
  "error_message": "Login or password is incorrect"
}
```

**Create note (Authorization required)**

##### HTTP Request
> POST http://localhost:3000/api/v1/notes

##### Query Parameters
| Param | Type| Required | Description |
| --- | --- | --- | --- |
| body | string(2...255) | yes | Note text |
| remind_at_utc | string(16), format(YYYY-MM-DD HH:MM) | yes | Time of sending push notification in UTC format. |

##### Request example
```bash
curl -H "Content-Type: application/json" -H "X-User-Email: test@example.com" -H "X-User-Token: e812xctHtE2ktjjw7_B4" -X POST -d '{ "body":"Test message","remind_at_utc":"2017-12-01 22:32" }' http://localhost:3000/api/v1/notes
```
##### Success response
```json
{
  "status": "success",
  "data": {
    "id": 1,
    "remind_at": "2017-12-02T00:32:00.000+02:00"
  }
}
```
##### Error response
```json
{
  "status": "error",
  "error_messages": {
    "body": ["can't be blank", "is too short (minimum is 2 characters)"]
  }
}
```


**Authorization methods**

! To get the *user_token* you need to send user login(api method) and in the answer get it.

1. You can authenticate passing the user_email and user_token params as query params:
    ```bash
    curl --data "user_email=test@example.com&user_token=e812xctHtE2ktjjw7_B4" http://localhost:3000/api/v1/notes
    ```
2. You can also use request headers:
    ```bash
    curl -H "X-User-Email: test@example.com" -H "X-User-Token: e812xctHtE2ktjjw7_B4" http://localhost:3000/api/v1/notes
    ```

##### Error response
> 401 Unauthorized