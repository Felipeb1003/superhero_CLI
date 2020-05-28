class API
    
    TOKEN = 10158132119596768
    def self.fetch_superhero(input)
       
        @input=input.gsub(/\s+/, "%20")
        @input
        url = 'https://www.superheroapi.com/api.php/10158132119596768/search/' + @input
        uri = URI(url)
        response = Net::HTTP.get(uri)
        hash= JSON.parse(response)

        if hash["response"] == "error"
            false
        else    
            array_of_superheroes = hash["results"]
        
        
            array_of_superheroes.each do |hero|
    
                superhero_instance= SuperHero.new
        
                superhero_instance.id = hero["id"]
                superhero_instance.name = hero["name"]
                superhero_instance.powerstats= hero["powerstats"]
                superhero_instance.biography = hero["biography"]
                superhero_instance.appearance = hero["appearance"]
                superhero_instance.work = hero["work"]
            
                
            end
            
        end
        
         
      
    end
end