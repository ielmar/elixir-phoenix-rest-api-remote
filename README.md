# Backend code exercise

Hi there!

If you're reading this, it means you're now at the coding exercise step of the engineering hiring process. We're really happy that you made it here and super appreciative of your time!

In this exercise you're asked to create a Phoenix application and implement some features on it.

> 💡 The Phoenix application is an API

If you have any questions, don't hesitate to reach out directly to [code_exercise@remote.com](mailto:code_exercise@remote.com).

## Expectations

- It should be production-ready code - the code will show us how you ship things to production and be a mirror of your craft.
  - Just to be extra clear: We don't actually expect you to deploy it somewhere or build a release. It's meant as a statement regarding the quality of the solution.
- Take whatever time you need - we won’t look at start/end dates, you have a life besides this and we respect that! Moreover, if there is something you had to leave incomplete or there is a better solution you would implement but couldn’t due to personal time constraints, please try to walk us through your thought process or any missing parts, using the “Implementation Details” section below.

## What will you build

A phoenix app with 2 endpoints to manage users.

We don’t expect you to implement authentication and authorization but your final solution should assume it will be deployed to production and the data will be consumed by a Single Page Application that runs on customer’s browsers.

To save you some setup time we prepared this repo with a phoenix app that you can use to develop your solution. Alternatively, you can also generate a new phoenix project.

## Requirements

- We should store users and salaries in PostgreSQL database.
- Each user has a name and can have multiple salaries.
- Each salary should have a currency.
- Every field defined above should be required.
- One user should at most have 1 salary active at a given time.
- All endpoints should return JSON.
- A readme file with instructions on how to run the app.

### Seeding the database

- `mix ecto.setup` should create database tables, and seed the database with 20k users, for each user it should create 2 salaries with random amounts/currencies.
- The status of each salary should also be random, allowing for users without any active salary and for users with just 1 active salary.
- Must use 4 or more different currencies. Eg: USD, EUR, JPY and GBP.
- Users’ name can be random or populated from the result of calling list_names/0 defined in the following library: [https://github.com/remotecom/be_challengex](https://github.com/remotecom/be_challengex)

### Tasks

1. 📄 Implement an endpoint to provide a list of users and their salaries
    - Each user should return their `name` and active `salary`.
    - Some users might have been offboarded (offboarding functionality should be considered out of the scope for this exercise) so it’s possible that all salaries that belong to a user are inactive. In those cases, the endpoint is supposed to return the salary that was active most recently.
    - This endpoint should support filtering by partial user name and order by user name.
    - Endpoint: `GET /users`

2. 📬 Implement an endpoint that sends an email to all users with active salaries
    - The action of sending the email must use Remote’s Challenge lib: [https://github.com/remotecom/be_challengex](https://github.com/remotecom/be_challengex)
    - ⚠️ This library doesn’t actually send any email so you don’t necessarily need internet access to work on your challenge.
    - Endpoint: `POST /invite-users`

### When you're done

- You can use the "Implementation Details" section to explain some decisions/shortcomings of your implementation.
- Open a Pull Request in this repo and send the link to [code_exercise@remote.com](mailto:code_exercise@remote.com).
- You can also send some feedback about this exercise. Was it too big/short? Boring? Let us know!

---

## How to run the existing application

You will need the following installed:

- Elixir >= 1.14
- Postgres >= 14.5

Check out the `.tool-versions` file for a concrete version combination we ran the application with. Using [asdf](https://github.com/asdf-vm/asdf) you could install their plugins and them via `asdf install`.

### To start your Phoenix server

- Run `mix setup` to install, setup dependencies and setup the database
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Endpoints

- Run `curl -X GET http://localhost:4000/api/users` to get the list of users with active salaries. Last updated salary will be shown for users with no active salary. `filter_name`, `order_by`, `offset` and `limit` query params are supported. Default `limit` is 100. Default `order_by` is by id. Add `order_by=name` to order by name. Default offset is 0.
- Run `curl -X GET http://localhost:4000/api/users/11319` to get the user with salaries for the given id. 
- Run `curl -X POST http://localhost:4000/api/users -d '{"user":{"name":"Sanan"}}' -H 'Content-Type: application/json'` to add a new user name
- Run `curl -X PUT http://localhost:4000/api/users -d '{"id":11312, "user":{"name":"Hakan"}}' -H 'Content-Type: application/json'` to update user name for the given id
- Run `curl -X DELETE http://localhost:4000/api/users/11312` to delete user for the given id
- Run `curl -X POST http://localhost:4000/api/invite-users` to send email to all users with active salaries
- Run `curl -X GET http://localhost:4000/api/salaries` to get the list of salaries. 
- Run `curl -X GET http://localhost:4000/api/salaries/11312` to get the salary for the given id.
- Run `curl -X POST http://localhost:4000/api/salaries -d '{"salary":{"user_id":11312, "amount": 1000, "currency": "USD"}}' -H 'Content-Type: application/json'` to add a new salary for the given user id. If active value is provided, it will be set to true and will set previous active salary to false. Otherwise, it will be set to false.
- Run `curl -X PUT http://localhost:4000/api/salaries -d '{"id":11312, "salary":{"amount": 2000, "currency": "USD"}}' -H 'Content-Type: application/json'` to update salary for the given id
- Run `curl -X DELETE http://localhost:4000/api/salaries/11312` to delete salary for the given id


---

## Implementation details

The project can be extended to consider many more features. I have tried to keep it simple and focused on the requirements. Extra features can be added in the future. Some of the features that can be added are:
- Authentication and authorization
- Keeping log of emails sent in order to avoid sending duplicate emails
- Analytics to get information about emails sent
- Statistics about users and salaries
