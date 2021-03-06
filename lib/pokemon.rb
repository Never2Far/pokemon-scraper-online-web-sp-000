class Pokemon

attr_accessor :name, :type, :db
attr_reader :id

    def initialize(name:, type:, db:, id: nil)
        @name = name
        @type = type
        @db = db
        @id = id
    end

    def self.save(name, type, db)
          sql = <<-SQL
              INSERT INTO pokemon (name, type)
              VALUES (?, ?)
          SQL
    
          db.execute(sql, name, type)
    
        #   pokemon.id = DB[:conn].execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end

    def self.new_from_db(row)
        new_pokemon = self.new(name: row[1], type: row[2], id: row[0], db: @db)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
            LIMIT 1
        SQL

        db.execute(sql, id).map{ |row|
            self.new_from_db(row)
          }.first
    end
end
