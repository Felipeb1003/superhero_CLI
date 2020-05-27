class SuperHero

    attr_accessor :id, :name, :powerstats, :biography, :appearance, :work
    @@all = []

    def initialize
        @@all << self
    end

    def self.all
        @@all
    end
end