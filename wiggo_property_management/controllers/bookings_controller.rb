require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/guest')
require_relative('../models/property')
require_relative('../models/booking')
also_reload('../models/*')

get '/bookings' do
  @bookings = Booking.sort_by_property
  erb(:"bookings/index_booking")
end

get '/bookings/new' do
  @guests = Guest.all
  @properties = Property.all
  erb(:"bookings/new_booking")
end

post '/bookings' do
  @booking = Booking.new( params )
  @booking.save()
  erb(:"bookings/create_booking")
end

get '/bookings/:id' do
  @booking = Booking.find(params['id'])
  erb(:"bookings/show_booking")
end

get '/bookings/:id/edit' do
  @guests = Guest.all
  @properties = Property.all
  @booking = Booking.find(params['id'])
  erb(:"bookings/edit_booking")
end

post '/bookings/:id' do
  Booking.new(params).update
  erb(:"bookings/update_booking")
end

post '/bookings/:id/delete' do
  booking = Booking.find(params['id'])
  booking.delete
  erb(:"bookings/delete_booking")
end
