require 'httparty'
require 'pry'

HTTParty::Basement.default_options.update(verify: false)

# "https://maps.googleapis.com/maps/api/distancematrix/json?origins=" + origin + "&destinations=" + destinations + "|" + destinations + " &key=AIzaSyCEgY30ofql0NkPFP8wPK8VfHqmSqOnQY4"

# curl -i -H "Accept: application/json" "https://maps.googleapis.com/maps/api/distancematrix/json?origins=1+Calvert+Drive+Monsey+NY|11+Broadway+NY+NY&destinations=1+Linderman+Lane+Monsey+NY|13+Ralph+Blvd+Monsey+NY&key=AIzaSyCEgY30ofql0NkPFP8wPK8VfHqmSqOnQY4"

# origin | origin => destination | destination

# get all permutations
# add them up for each route
def permutation(locations)
  locations.permutation.to_a.each_with_object([]) do |perm, all_times| 
    all_times << get_route(perm)
  end
end


def get_route(locations)
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
  all_times.each do |route|
    route.each do |time|
      binding.pry
  end
end


def run(locations)
  all_times = permutation(locations)
  parse_time(all_times)
end

locations = ["11 Broadway New York NY", "Park Slope NY", "1 Linderman Ln Monsey NY"]
run(locations)


