require 'pry'

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
attr_reader :id, :name, :grade

def initialize(name,grade,id=nil)
  @name = name
  @grade = grade
end

def self.create_table
  DB[:conn].execute "CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, grade INTEGER);"
end

def self.drop_table
  DB[:conn].execute "DROP TABLE IF EXISTS students;"
end

def self.create(students_hash)
  new_student = Student.new(students_hash[:name],students_hash[:grade])
  DB[:conn].execute "INSERT INTO students(name,grade) VALUES (?,?);", students_hash[:name], students_hash[:grade]
  new_student
end

def save
  DB[:conn].execute "INSERT INTO students(name,grade) VALUES (?,?);", @name, @grade
  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
end

end
