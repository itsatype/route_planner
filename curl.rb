# require 'curb'
require 'pry'
require 'json'
require 'httparty'
HTTParty::Basement.default_options.update(verify: false)

  # response = Curl::Easy.perform("https://maps.googleapis.com/maps/api/distancematrix/json?origins=59 Route 59 Monsey NY 10952&destinations=11 Broadway New York NY&key=AIzaSyCEgY30ofql0NkPFP8wPK8VfHqmSqOnQY4")
  HTTParty.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=59 Route 59 Monsey NY 10952&destinations=11 Broadway New York NY&key=AIzaSyCEgY30ofql0NkPFP8wPK8VfHqmSqOnQY4")
  # x = response.body_str
  binding.pry
  json = JSON.parse(x)
  json["rows"]
  puts 'hi'