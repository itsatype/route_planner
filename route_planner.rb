require 'httparty'
require 'pry'

HTTParty::Basement.default_options.update(verify: false)


# get all permutations
# add them up for each route

def route_permutations(locations)
  locations.permutation.to_a
end

def get_route(all_permutations, origin)
  all_permutations.collect { |locations|  route_from_maps_api(locations, origin) }
end


def route_from_maps_api(locations, origin)
  locations.each_with_object([]).with_index do |(location, time), index|
    if index == 0
      response = HTTParty.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{origin}&destinations=#{location}&key=AIzaSyCEgY30ofql0NkPFP8wPK8VfHqmSqOnQY4")
      time << response["rows"].first["elements"].first["duration"]["text"]
    else
      response = HTTParty.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{locations[index-1]}&destinations=#{location}&key=AIzaSyCEgY30ofql0NkPFP8wPK8VfHqmSqOnQY4")
      time << response["rows"].first["elements"].first["duration"]["text"]
    end
  end
end


def parse_time(all_times)
  all_times.collect do |route|
    route.collect { |time| hours_to_mins(time) }
  end
end

def hours_to_mins(time)
  split_time = time.split(" ")
  split_time.include?("hour") ? split_time.first.to_i * 60 + split_time[2].to_i : split_time.first.to_i
end

def get_fastest_route(minutes_in_route)
  minutes_in_route.collect { |minutes| minutes.reduce(:+) }.each_with_index.min
end

def run(locations)
  all_permutations = route_permutations(locations)
  all_times = get_route(all_permutations, "59 Route 59 Monsey NY 10952")
  minutes_in_route = parse_time(all_times)
  fastest_route = get_fastest_route(minutes_in_route)
  all_permutations[fastest_route.last]
end

locations = ["5 Calvert Dr Monsey NY", "1 Linderman Ln Monsey NY", "20 Robert Pitt Monsey NY"]

puts run(locations)


