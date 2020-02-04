require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title

  def initialize(options)
    @title = options['title']
    @id = options['id'].to_i if options['id']
  end

# moved price to screenings
  def save()
    sql = "INSERT INTO films
    (
      title
      )
      VALUES
      (
      $1
      )
      RETURNING id"
      # I am not 100% sure what is happening on line 26
    values = [@title]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "
    UPDATE films SET (
      title
    ) =
    (
      $1
    )
    WHERE id = $2"
    values = [@title, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
  sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
  values = [@id]
  customer_data = SqlRunner.run(sql, values)
  return customer_data.map {|customer| Customer.new (customer)}
  end

# this needs to be refactored as no longer works?
  def customer_count()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON tickets.customer_id = customers.id WHERE film_id = $1"
    values = [@id]
    ticket_data = SqlRunner.run(sql, values)
    customers = ticket_data.map{|ticket| Ticket.new(ticket)}
    return customers.count
    # return customers.uniq {|customer| customer} do I actually need this?
  end

  def screenings()
    sql = "SELECT * FROM screenings WHERE film_id = $1"
    values = [@id]
    screenings_data = SqlRunner.run(sql, values)
    # screenings_data looks like: [{"time"=>12:30}, {"time"=>12:45}]
    screenings_objects = screenings_data.map {|screening| Screening.new(screening)}
    # return value [Screenings_object, Screenings_object]
    return screenings_objects
  end

  def most_popular_time()
    screenings_for_film = screenings()
    sorted_screenings = screenings_for_film.sort_by {|screening| screening.tickets_sold()}
    return sorted_screenings.last()
  end

  def self.all()
  sql = "SELECT * FROM films"
  films = SqlRunner.run(sql)
  result = films.map { |user| Film.new( user ) }
  return result
end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end


end
