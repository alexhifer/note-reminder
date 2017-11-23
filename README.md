# note-reminder

- Ruby version: 2.4.2
- Rails version: 5.1.4

## How to play:

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
5. Create databases
   > rake db:create
5. Loads the seed data
   > rake db:seed
6. Start web server
   > rails s
7. Open admin zone in browser (login: note_reminder@example.com, password: qwerty123)
   > http://localhost:3000/admin
   
## API Documentation

The query parameters can be HTTP or JSON

**User registration**

##### HTTP Request
> POST http://localhost:3000/api/v1/sign_up

##### Query Parameters
| Param | Description |
| --- | --- |
| email | User e-mail address |
| password | User password |

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
#### Request example
> curl --data "email=test@example.com&password=qwerty123 http://localhost:3000/api/v1/sign_up

#### Response example
```json
{
  "status": "success",
  "data": {
    "id": 1,
    "email": "test@example.com"
  }
}
```

**User login**

##### HTTP Request
> POST http://localhost:3000/api/v1/sign_in

##### Query Parameters
| Param | Description |
| --- | --- |
| email | User e-mail address |
| password | User password |

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
#### Request example
> curl --data "email=test@example.com&password=qwerty123" http://localhost:3000/api/v1/sign_in

#### Response example
```json
{
  "status": "success",
  "data": {
    "user_token": "CQFJgyPTLkszmsyr_dBD"
  }
}
```