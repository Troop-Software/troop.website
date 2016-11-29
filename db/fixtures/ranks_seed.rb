ranks =['Just Joined', 'Scout', 'Tenderfoot', 'Second Class', 'First Class', 'Star', 'Life', 'Eagle']

ranks.each do |rank|
  Rank.seed(name: rank)
end
