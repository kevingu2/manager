# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Oppty.delete_all
History.delete_all
UserOppty.delete_all
UserHistory.delete_all
Notification.delete_all
NotificationHistory.delete_all
