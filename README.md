# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version: 2.5.3

- Run following commands to setup database:

    - rake db:create

    - rake db:migrate

- Need to add master.key file in config folder

APIs:
## Signup  
- **Type:** POST

- **URL:** /auth

- **Sample Body:**
```json
{
  "email": "test@gmail.com",
  "name":"test",
  "pan_number":"CMPLP66928",
  "password": "12345678",
  "password_confirmation": "12345678"
}
```
- **Description**: This service will create a user account as well as a bank account.

****

## Login  
- **Type:** POST

- **URL:** /auth/sign_in

- **Sample Body:**  
    
```json
{
  "email": "test@gmail.com",
  "password": "12345678",
}
```
- **Response Header:**  
These keys need to be passed in every request header
```json
access-token :9Z67F68KoXI2pxWyaRdreQ
token-type :Bearer
client :NMVitL6tQiO5N3gaq0esBA
expiry :1566656076
uid :test@gmail.com
```
****

## List all accounts of logged in user
- **Type:** GET

- **URL:** /accounts

****

## Show account details
- **Type:** GET

- **URL:** /accounts/:id

****

## List all transactions of an account
- **Type:** GET

- **URL:** /accounts/:id/list_transactions

****

## Create Transaction
- **Type:** POST

- **URL:** /transactions

- **Sample Body:**  
    
```json
{
	"mode":"online",
	"amount":1000,
	"sender_account_number":100000000000,
	"recipient_account_number":100000000001
}
```
****

## Account summary
- **Type:** GET

- **URL:** /accounts/:id/status
