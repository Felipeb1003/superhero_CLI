class CLI 
   def start
      puts "Welcome to the Superhero fact checker!"
      self.first_step
   end
  
   def first_step
      puts "Would you like to begin? (y/n)"
      user_input = gets.strip.downcase
      if user_input == "y" || user_input == "yes"
        self.ask_user_for_superhero_name
        self.select_a_superhero
        self.select_a_category
       
      else 
        puts "We hope you gather the imformation and knwodledge you were looking for. See you next time..."
      end
   end

   def display_search_name_result
      SuperHero.all.each.with_index(1) do |hero , index|
        puts "#{index}. #{hero.name}."
      end
   end

   def display_categories
     
   end

   def ask_user_for_superhero_name
      puts"Please enter the name of the Superhero you are looking for:"
      input_superhero_name= gets.strip.downcase
    
     #Validate the input
      until API.fetch_superhero(input_superhero_name)
        puts "Superhero not found."
        input_superhero_name= gets.strip.downcase
      end
        self.display_search_name_result
    end
    
    

    def select_a_superhero
      puts "Please Select the character you would like to look at:"
       index = gets.strip.to_i - 1

       #Validate input
       max_limit = SuperHero.all.length - 1
       until index.between?(0, max_limit)
        puts "Invalid number."
        index = gets.strip.to_i - 1
       end
       superhero_instance= SuperHero.all[index]
       puts "*#{superhero_instance.name}"
       
    end
       
    def select_a_category
      puts "Please select the category that you would like to see:"
    end
 
end