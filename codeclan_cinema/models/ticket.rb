require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :screening_id, :film_id

  def initialize(options)
    @customer_id = options['customer_id'].to_i
    @screening_id = options ['screening_id'].to_i
    @film_id = options['film_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      screening_id,
      film_id
      )
      VALUES
      (
      $1,
      $2,
      $3
      )
      RETURNING id"
      # I am not 100% sure what is happening on line 26
    values = [@customer_id, @screening_id, @film_id]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "
    UPDATE tickets SET (
      customer_id,
      screening_id,
      film_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@customer_id, @screening_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
  sql = "SELECT * FROM tickets"
  tickets = SqlRunner.run(sql)
  result = tickets.map { |user| Ticket.new( user ) }
  return result
end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.find_film(film_id)
  sql = "SELECT * FROM tickets WHERE film_id = $1"
  values = [film_id]
  film_data = SqlRunner.run(sql,values)
  result = film_data.map{|ticket| Ticket.new(ticket)}
  return result
  end

  def self.tickets_sold(screening_id)
    sql = "SELECT * FROM tickets WHERE screening_id = $1"
    values = [screening_id]
    film_data = SqlRunner.run(sql,values)
    # result = film_data.map{|ticket| Ticket.new(ticket)}
    return film_data.count
  end

# just couldn't work out how to do this!
  def self.most_tickets(film_id)
    # result = self.find_film(film_id)
    # return result.reduce {|sum, result| sum += result}

    # return result.values.count(@screening_id)
    # return result.screening_id.max {|current_screening, next_screening| current_screening <=> next_screening}
  end
end
