# ap1q_construct_a_int.R

# Load necessary libraries
library(plumber)
library(jsonlite)
library(httr)

# Define the API endpoints
apis <- list(
  "/users" = function(req, res) {
    # Simulate a list of users
    users <- list(
      list(id = 1, name = "John Doe", email = "john@example.com"),
      list(id = 2, name = "Jane Doe", email = "jane@example.com")
    )
    res$status <- 200
    res$body <- toJSON(users, auto_unbox = TRUE)
  },
  "/users/{id}" = function(req, res) {
    # Simulate a single user by ID
    id <- as.integer(req:path("id"))
    user <- list(id = id, name = paste("User", id), email = paste("user", id, "@example.com", sep = ""))
    res$status <- 200
    res$body <- toJSON(user, auto_unbox = TRUE)
  },
  "/orders" = function(req, res) {
    # Simulate a list of orders
    orders <- list(
      list(id = 1, user_id = 1, total = 100.0),
      list(id = 2, user_id = 1, total = 200.0),
      list(id = 3, user_id = 2, total = 50.0)
    )
    res$status <- 200
    res$body <- toJSON(orders, auto_unbox = TRUE)
  }
)

# Create the API service
api <- plumb("api")
api$POST("/", apis)
api$run()