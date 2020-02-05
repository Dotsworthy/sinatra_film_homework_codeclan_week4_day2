require_relative( 'models/ticket' )
require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/screening')


require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()
Screening.delete_all()


customer1 = Customer.new({'name' => 'Arnold', 'funds' => '20.00'})
customer1.save()
customer2 = Customer.new({'name' => 'Sylvester', 'funds' => '15.00'})
customer2.save()
customer3 = Customer.new({'name' => 'Wesley', 'funds' => '0.00'})
customer3.save()

film1 = Film.new({'title'=> 'Terminator'})
film1.save()
film2 = Film.new({'title'=> 'Rambo'})
film2.save()
film3 = Film.new({'title' => 'Blade'})
film4 = Film.new({'title' => 'Commando'})
film4.save()

screening1 = Screening.new({'film_id' => film1.id, 'tickets_available' => '2', 'showing' => '20:00', 'day' => 'Monday', 'type' => '2D standard', 'price' => '7.95'})
screening1.save()
screening2 = Screening.new({'film_id' => film1.id, 'tickets_available' => '3', 'showing' => '18:30', 'day' => 'Monday', 'type' => '2D standard', 'price' => '7.95'})
screening2.save()

ticket1 = Ticket.new({'screening_id' => screening1.id, 'film_id' => screening1.film_id, 'customer_id' => customer1.id})
ticket1.save()
ticket2 = Ticket.new({'screening_id' => screening2.id, 'film_id' => screening2.film_id, 'customer_id' => customer2.id})
ticket2.save()
ticket3 = Ticket.new({'screening_id' => screening1.id, 'film_id' => screening1.film_id, 'customer_id' => customer1.id})
ticket3.save()

binding.pry()
nil
