class Book

 attr_accessor :id, :description, :author


  def self.open_connection
    conn = PG.connect(dbname: "books", user:"postgres", password:"Acad3my1")
  end

  def self.all
    conn = self.open_connection
    sql  = "SELECT * FROM books ORDER BY id"
    results = conn.exec(sql)


    books = results.map do |tuple|
      self.hydrate tuple
    end
    return books
  end

  def self.find id
    conn = self.open_connection
    sql = "SELECT * FROM books WHERE id = #{id}"
    result = conn.exec(sql)

    books = self.hydrate result[0]
    return books
  end

  def self.hydrate books_data
    books = Book.new
    books.id = books_data['id']
    books.author = books_data['author']
    books.description = books_data['description']

  return books
end

  def save
    conn = Book.open_connection
    if (!self.id)
    sql = "INSERT INTO books (author, description) VALUES('#{self.author}', '#{self.description}')"
    else
    sql = "UPDATE books SET author = '#{self.author}', description = '#{self.description}' WHERE id = '#{self.id}'"
    end
    conn.exec(sql)

  end

  def self.destroy id
    conn = Book.open_connection
      sql = "DELETE FROM books WHERE id ='#{id}'"
      conn.exec(sql)

    end
end
