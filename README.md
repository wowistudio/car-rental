# CAR RENTAL SERVICE

### Basics & setup

**Services**

*Postgres*
- For info credentials defaults, see `config/database.yml`
- Run `make up` to start the postgres container with docker compose

*Ruby*
- Rake version `13.0.6`
- Ruby version `2.6.6`

**Setup app**
```bash
# Install all the necessary dependencies
bundle install

# Reset the database, run migrations and seed database
# Do this again and again to start with a clean sheet
make reset
```

The following records will be added to the database:
```ruby
Member.create(uid:  'G-584294-FM', membership:  'gold')
Member.create(uid:  'N-59323519', membership:  'regular')
Vehicle.create(uid:  'M1')
```
 
**Starting server**
```bash
$ rails server
```
To check if the server is healthy:
```bash
$ curl http://localhost:3000/monitoring/health
👍 All good
```

### Usage

**Member authentication**

Include `X-Member-Id` header with every request

**Interact via Postman**
- Import `./CarRental.postman_collection.json` into Postman
- Execute the requests in order

**Interact via Curl**

I've created a folder `./api-calls` where I put a file with some commands and a single file for each command where POST data can be altered.

```sh
# Go into api-calls folder
cd api-calls

# Source commands file
source api-calls.sh

# Set member id (used for authentication)
# Defaults to id of regular member
export MEMBER_ID="G-584294-FM"

# 1. Rent a vehicle
$ rent_vehicle

# 2. Add pledge until sufficient (regular member only)
$ add_pledge

# 3. Return vehicle
$ return_vehicle

# 4. Add money until sufficient
$ add_amount

# 5. Get cashback
$ get_cashback
```
