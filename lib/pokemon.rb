# pokemon(id INTEGER PRIMARY KEY, name TEXT, type TEXT)

class Pokemon
  attr_reader :name, :type
  attr_accessor :id, :db, :hp
  @@all = []
  def initialize(row)
    @id = row[:id]
    @name = row[:name]
    @type = row[:type]
    @db = row[:db]
    @hp = row[:hp]

    @@all << self
  end

  def self.save(name, type, db)
    Pokemon.new({id: nil, name: name, type: type, db: db})
    db.execute("INSERT INTO pokemon (name, type) VALUES ('#{name}', '#{type}');")
    @id = "SELECT id FROM pokemon WHERE id = (SELECT MAX(id) FROM pokemons);"
  end

  def self.find(id, db)
    found_pok = db.execute("SELECT * FROM pokemon WHERE id = #{id};")
    new_pokemon = Pokemon.new({id: found_pok[0][0], name: found_pok[0][1], type: found_pok[0][2], hp: found_pok[0][3]})
    @@all.last
  end

  def alter_hp(hp, db)
    @hp = hp
    db.execute("UPDATE pokemon SET hp = #{hp} WHERE pokemon.name = '#{self.name}';")

  end


end
