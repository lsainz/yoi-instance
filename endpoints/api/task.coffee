"use strict"

Yoi    = require "yoi"
Tasks  = require "../../commons/models/task"

module.exports = (server) ->

  server.post "/api/task", (request, response, next) ->
    rest = new Yoi.Rest request, response
    #campo obligatorio
    rest.required ["name"]
    Tasks.create(_parameters(rest)).then (error, tasks) ->
      if error then rest.badRequest() else rest.run tasks.parse()


  server.get "/api/task", (request, response, next) ->
    rest = new Yoi.Rest request, response
    Tasks.findAll().then (error, tasks) ->
      if error then rest.badRequest() else rest.run task.parse() for task in tasks
            


_parameters = (rest) ->
  name        : rest.parameter("name").trim()
  description : rest.parameter "description"