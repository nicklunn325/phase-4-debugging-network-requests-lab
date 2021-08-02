# Putting it All Together: Client-Server Communication

## Learning Goals

- Understand how to communicate between client and server using fetch, and how
  the server will process the request based on the URL, HTTP verb, and request
  body
- Debug common problems that occur as part of the request-response cycle

## Introduction

Just like the last lesson, we've got code for a React frontend and Rails API
backend set up. This time though, it's up to you to use your debugging skills to
find and fix the errors!

To get the backend set up, run:

```sh
bundle install
rails db:migrate db:seed
rails s
```

Then, in a new terminal, run the frontend:

```sh
npm install --prefix client
npm start --prefix client
```

Confirm both applications are up and running by visiting
[`localhost:4000`](http://localhost:4000) and viewing the list of toys in your
React application.

## Deliverables

In this application, we have the following features:

- Display a list of all the toys
- Add a new toy when the toy form is submitted
- Update the number of likes for a toy
- Donate a toy to Goodwill (and delete it from our database)

The code is in place for all these features on our frontend, but there are some
problems with our API! We're able to display all the toys, but the other three
features are broken.

Use your debugging tools to find and fix these issues.

There are no tests for this lesson, so you'll need to do your debugging in the
browser and using the Rails server logs and `byebug`.

**Note**: You shouldn't need to modify any of the React code to get the
application working. You should only need to change the code for the Rails API.

As you work on debugging these issues, use the space in this README file to take
notes about your debugging process. Being a strong debugger is all about
developing a process, and it's helpful to document your steps as part of
developing your own process.

## Your Notes Here

- Add a new toy when the toy form is submitted

  - How I debugged:

    - first we tried to submit the form via frontend
    - we received error `POST http://localhost:4000/toys 500 (Internal Server Error)`
    - for internal server error, we first look at our server log and try and determine what went wrong
    - we saw this in our terminal:

    ```
    NameError (uninitialized constant ToysController::Toys):

    app/controllers/toys_controller.rb:10:in `create'
    ```

    - we went to line 10 in our toys_controller ands saw Toys.create instead of Toy.create

- Update the number of likes for a toy

  - How I debugged:

    - started by trying to click like button for toy
    - dom did not update and console had error `SyntaxError: Unexpected end of JSON input at ToyCard.js:21`
    - checked fetch request, looked good
    - next check controller action to make sure it is rendering json
    - it was not
    - we made it return the updated toy as json

- Donate a toy to Goodwill (and delete it from our database)

  - How I debugged:
  - Click the "Donate to GoodWill" button and watch behaviour
  - Looked at Network tab in dev tools response came back with Status Code: 404 Not Found
  - the server gave me this error ActionController::RoutingError (No route matches [DELETE] "/toys/1"):
  - From that last error I assume there is a missing rout for delete
  - Update resource to look like this "resources :toys, only: [:index, :create, :update, :destroy]"
  - Try "Donate to DoodWill" button again
  - Issue Solved
