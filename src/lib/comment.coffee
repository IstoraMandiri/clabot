'use strict'
fs   = require 'fs'
path = require 'path'

_      = require 'lodash'
github = require 'github'

exports.getCommentBody = (signed, templates, templateData) ->
  if arguments.length is 2
    templateData = templates
    templates = {}

  if signed
    unless templates.alreadySigned
      templates.alreadySigned = fs.readFileSync path.resolve(__dirname,
          '../templates'
          'alreadySigned.template.md')
        , 'UTF-8'
    _.template templates.alreadySigned, templateData
  else
    unless templates.notYetSigned
      templates.notYetSigned = fs.readFileSync path.resolve(__dirname,
          '../templates'
          'notYetSigned.template.md')
        , 'UTF-8'
    _.template templates.notYetSigned, templateData

exports.send = (token, msg, callback) ->
  api = new github
    version: '3.0.0'

  api.authenticate
    type: 'oauth'
    token: token

  api.issues.createComment msg, callback
