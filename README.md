# note-reminder

- Ruby version: 2.4.2
- Rails version: 5.1.4

## How to play:

1. clone repository
    ```bash
    git clone https://github.com/alexhifer/note-reminder.git
2. installing gems
    ```bash
    bundle install
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
   ```bash
   rake db:create