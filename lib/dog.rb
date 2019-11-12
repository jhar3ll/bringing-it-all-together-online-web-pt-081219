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
     @id = DB[:conn].execute("")

end 