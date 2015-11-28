== README

#Duckbills

This is the API for a web application that facilitates the splitting up of bills between roommates.  The person whos name is on the bill can register as a treasurer.  They can then creat roomates and assign portions (or total amounts) of bills to them with apllicable due dates.  Anyone using this API has the option of searching by bill and by asignee.

Possibilities for future versions will support voting on roomates (based on payment history) and messaging/alerts.

#Table of Contents
1. [Authentication](#authenticate)
2. [Create Treasurer](#register)
3. [Create Roommates](#roommate)
4. [Create Bills](#create_bill)
5. [Edit Bills](#edit_bill)
6. [See Rommates](#roommates)
7. [See All Bills](#all_bills)
8. [See a Rommates Bills](#roommates_bills)
9. [See Single Bill](#single_bill)

##Authentication <a id="authenticate"></a>
### The authentication token must be passed in the headers as access_token

##Register Treasurers Account <a id="register"></a>

###POST `/treasurers`

**Params**

- `living_space`: The name of the living space
- `username`: A username must be unique
- `name`: Treasurers first name and last name
- `email`: An email must be unique and have an @ symbol followed by a "."
- `password`: A password must be at least 8 characters

**Response**

If user was created successfully it will return status code 201

```
 {
	"living_space": "The iron yard"
	"admin": true
	"username": "Charlie_1980"
	"name": "Charles Alderete"
	"email": "ninja@kittens.com"
	"access_token": "......"
	}
```

If the treasurer could not be created you should receive status code 422 and 

{
	"errors" [
	"Email has already been taken", Username has already been taken]
}

##Create Roomates <a id="rommate"></a>

###POST `/roomates`

_Only treasurers can create roomates_

**Params**

`username`: A username must be unique
`name`: Treasurers first name and last name
`email`: An email must be unique and have an @ symbol followed by a "."
`password`: A password must be at least 8 character
'treasurer_id`: The id of the treasurer that the roommate pays too 

```

 {
	"living_space": "The iron yard"
	"admin": "false"
	"username": "Charlie_1980"
	"name": "Charles Alderete"
	"email": "ninja@kittens.com"
	"access_token": "......"
	}
```

If the roomate was successfully created you will receive status code 201

If the roomate could not be created you should receive status code 422 and 

{
	"errors" [
	"Email has already been taken", Username has already been taken]
}

##Create Bills <a id="create_bill"></a>

_once rommates are created by the treasurer bills can be assigned to them_

###POST `/bills/create`

Only treasurers can create bills

**Params**

* `name`: Name of bill 
* `total_balance` Total amount of bill
* `your_balance` Amount of money the roomate is paying on the bill
* `due_date` The date the bill is due
* `company` The company the bill is being paid too
* `roomate_id` The id of the roomate the bill belongs too
* `treasurer_id` The id of the treasurer that the bill belongs too

If bill is created you will receive a status code 201 and 

```
  {
	"name": "Bunnies"
	"total_balance": "800"
	"your_balance": "400"
	"company": "Bunnies R Us"
	"roomate_id": "1"
	"treasurer_id": "1"
	"due_date": "2012-03-27 23:53:38 UTC"
	}
```
##Edit Bills <a id="edit_bill"></a>

###PUT `/bills/:id`

**Params**

* `your_balance:` The balance remaining on the roomates bill
* `company:` The company the bill is paid to
* `treasurer_id:` The id of whos name is on the bill
* `due_date:` The date the bill is due in `.datetime`
* `paid:` A `boolean` marking wheather or not the bill has been paid
* `assignee:` A roomate who is contributing to this bill

##See a treasurers roommates <a id="rommates"></a>

###GET `/roomates/:treasure_id`

**Params**

* `treasurer_id:` The id of the treasurer the roomate is associated with `integer:`

###This will return an array of hashes

```
[
  {
    "id": 2,
    "username": "Charlie",
    "email": "ninja@kittens.com",
    "admin": false,
    "name": "CharlesCharlie"
  },
  {
    "id": 3,
    "username": "Also Charlie",
    "email": "ninja@kittens.com1",
    "admin": false,
    "name": "CharlesCharlie"
  },
```

#Search Bills

There are 3 methods to search for bills

## GET /bills/:treasurer_id <a id="all_bills"></a>

**Params**

* `treasurer_id:` The id of the person whos name is on the bill `integer` and it will return an array of hashes

```
[
  {
    "name": "bunnies",
    "total_balance": 400,
    "your_balance": 800,
    "company": "bunnies are us",
    "assignee": "bill duck",
    "due_date": "2012-12-12T00:00:00.000Z",
    "paid": false,
    "days_past_due": null
  },
  {
    "name": "bunny cleaner",
    "total_balance": 400,
    "your_balance": 800,
    "company": "bunnies are us",
    "assignee": "bill duck",
    "due_date": "2012-12-12T00:00:00.000Z",
    "paid": false,
    "days_past_due": null
  }
]
```

## GET /bills/assignee/:assignee <a id="rommates_bills"></a>

**Params**

* `assignee:` The person whos bills you wish to search for

This will return all bills by the `assignee:` param

#GET /bills/bill/:id <a id="single_bill"></a>

**Params**

* `id` The id of the bill you wish to see `integer`

This will return json of an indivdual bill


