require 'httparty'
require 'pry'

HTTParty::Basement.default_options.update(verify: false)


# get all permutations
# add them up for each route

def permutations(locations)
  locations.permutation.to_a
end

def get_route(all_permutations)
  all_permutations.collect { |locations|  route_from_maps_api(locations) }
end


def route_from_maps_api(locations)
  origin = "59 Route 59 Monsey NY 10952"
  origin_count = 0
  i = 0
  time = Array.new
  while i < locations.length-1  do
    if origin_count == 0
      response = HTTParty.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=" + origin + "&destinations=" + locations[i] + "&key=AIzaSyCEgY30ofql0NkPFP8wPK8VfHqmSqOnQY4")
      time << response["rows"].first["elements"].first["duration"]["text"]
      origin_count +=1
    else
      response = HTTParty.get("https://maps.googleapis.com/maps/api/distancematrix/json?origins=" + locations[i] + "&destinations=" + locations[i+1] + " &key=AIzaSyCEgY30ofql0NkPFP8wPK8VfHqmSqOnQY4")
      time << response["rows"].first["elements"].first["duration"]["text"]
      i +=1
    end
  end
  time
end


def parse_time(all_times)
  all_times.collect do |route|
    route.collect { |time| hours_to_mins(time) }
  end
end

def hours_to_mins(time)
  split_time = time.split(" ")
  split_time.length == 4 ? split_time.first.to_i * 60 + split_time[2].to_i : split_time[2].to_i
end

def get_fastest_route(minutes_in_route)
  minutes_in_route.collect { |minutes| minutes.reduce(:+) }.each_with_index.min
end

def run(locations)
  all_permutations = permutations(locations)
  all_times = get_route(all_permutations)
  minutes_in_route = parse_time(all_times)
  fastest_route = get_fastest_route(minutes_in_route)
  all_permutations[fastest_route.last]
end

locations = ["11 Broadway New York NY", "1 Linderman Ln Monsey NY", "13 Ralph Monsey NY", "Park Slope NY"]
puts run(locations)


