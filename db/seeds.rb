# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['Waiting for Staff Response', 'Waiting for Customer', 'On Hold',
'Cancelled', 'Completed'].each { |status| Status.create(title: status) }

['Sales', 'Brokers', 'Security', 'Supervisors'].each do |dep|
  Department.create(title: dep)
end
