patrol_names =['unassigned','Blood Hounds', 'Screaming Eagles', 'Black Hawks', 'Morning', 'Wolverines']

patrol_names.each do |patrol|
  Patrol.seed(name: patrol)
end