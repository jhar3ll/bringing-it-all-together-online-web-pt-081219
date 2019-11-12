class Dog 
attr_accessor :name, :breed, :id

def initialize(name:, breed:, id: nil)
  @name = name 
  @breed = breed 
  @id = id
 end 
 
 def self.create_table
   sql = <<-SQL
   CREATE TABLE dogs (
   id INTEGER PRIMARY KEY,
   name TEXT,
   breed TEXT)
   SQL
   DB[:conn].execute(sql)
 end
 
 def self.drop_table
   sql = "DROP TABLE IF EXISTS dogs"
   DB[:conn].execute(sql)
 end 
 
 def save 
   if self.id
     self.update
   else 
     sql = "INSERT INTO dogs (name, breed) VALUES (?, ?)"
     DB[:conn].execute(sql, self.name, self.breed)
     @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
   end 
   return self 
 end

  def self.create(name:, breed:)
    dog = Dog.new(name: name, breed: breed)
    dog.save 
    return dog
  end 
  
  def self.new_from_db 
    sql = <<-SQL 
    SELECT *
    FROM dogs 
    WHERE name = ?, breed = ? 
    LIMIT 1 
    SQL
    
    dog = DB[:conn].execute(sql, name, breed)
    
    if !dog.empty? 
      dog_data = [0]
      dog = Dog.new[]
    
    
end 