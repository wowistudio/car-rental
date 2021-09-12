kurl() {
  member_id="${MEMBER_ID:-N-59323519}"
  curl -X "POST" -H "X-Member-Id: $member_id" -H "Content-Type: application/json" $@
}

rent_vehicle() {
  kurl http://localhost:3000/v1/rent-a-car/ --data @rent.json
}

make_pledge() {
  kurl http://localhost:3000/v1/pledge/ --data @pledge.json
}

return_vehicle() {
  kurl http://localhost:3000/v1/return-a-car/ --data @return.json
}

add_amount() {
  kurl http://localhost:3000/v1/pay-a-car/ --data @pay.json
}

get_cashback() {
  kurl http://localhost:3000/v1/cashback/
}
