describe '#hours_to_mins' do 
  it 'converts hours to minutes' do
    expect(hours_to_mins("1 hour 4 min")).to eq 64
  end

  it 'returns just the minutes' do 
    expect(hours_to_mins("35 mins")).to eq 35
  end
end


describe '#route_permutations' do 
  let (:permutations) { [["A", "B", "C"], ["A", "C", "B"], ["B", "A", "C"], ["B", "C", "A"], ["C", "A", "B"], ["C", "B", "A"]] }
  it 'finds all the permutations of an array' do
    expect(route_permutations(["A", "B", "C"])).to eq permutations
  end
end

describe '#minutes_in_route' do
  let(:route1) { [1, 60, 7] }
  let(:route2) { [61, 56, 7] }
  let(:route3) { [8, 64, 56] } 
  it 'sums all minutes in a route, and returns the shortest route with the index' do 
    expect(get_fastest_route([route1, route2, route3])).to eq [68, 0]
  end
end

describe '#run' do
  let(:locations) {["11 Broadway New York NY", "1 Linderman Ln Monsey NY", "20 Robert Pitt Monsey NY"] }  
  it 'returns the fastest route, given a list of addresses' do
    expect(run(locations)).to eq(["20 Robert Pitt Monsey NY", "1 Linderman Ln Monsey NY", "11 Broadway New York NY"])
  end
end