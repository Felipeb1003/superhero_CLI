class CLI 
    def start
      puts "\n"
      puts "\nWelcome to the Superhero fact checker!"
      self.first_step
    end
  
   def first_step
        puts "\nWould you like to begin?"
        puts "Type 'yes' to continue or any other key to exit."
        user_input = gets.strip.downcase
        if user_input == "yes" || user_input == "y"
          self.ask_user_for_superhero_name
          self.select_a_superhero
          self.display_categories
          self.select_a_category
          sleep(1)
          SuperHero.reset_all
          first_step     
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
      @categories = ["Appearance", "Biography", "Powerstats", "Work"]
      puts "Categories:"
      @categories.each.with_index(1) do |category, index|
        
        puts "#{index}. #{category}."
      end
    end

    def ask_user_for_superhero_name
        puts "\n"
        puts "Please enter the name of the Superhero you are looking for:"
        input_superhero_name= gets.strip.downcase
    
        #Validate the input
        until API.fetch_superhero(input_superhero_name) 
            puts "Superhero not found. (ง'̀-'́)ง Please try again."
            
            input_superhero_name= gets.strip.downcase
        end
               self.display_search_name_result
    end
    
    

    def select_a_superhero
      puts "\nPlease Select the character you would like to look at:"
       index = gets.strip.to_i - 1

       #Validate input
       max_limit = SuperHero.all.length - 1
       until index.between?(0, max_limit)
        puts "⇪ Invalid number. Please try again."
        index = gets.strip.to_i - 1
       end
       @superhero_instance= SuperHero.all[index]
       puts "\n *#{@superhero_instance.name}*"
       
    end
       
    def select_a_category
      puts "Please select the category that you would like to see:"
      index = gets.strip.to_i - 1
    
      #validate
      max_limit= @categories.length - 1

      until index.between?(0, max_limit)
        puts "⇪ Invalid number. Please try again."
        index = gets.strip.to_i - 1
      end  

      case index

      when 0
        puts "\n*#{@superhero_instance.name}*"
        puts "1. Appearance."
        puts "\n"
          
          @superhero_instance.appearance.each do |key, value|
              if key == "height" || key == "weight"
                puts "-#{key.capitalize} = #{value[0]} || #{value[1]} "
              elsif
                puts "-#{key.capitalize} = #{value}"
              end
          end

      when 1   
        puts "\n*#{@superhero_instance.name}*"
        puts "2. Biography."
        puts "\n"
        
        @superhero_instance.biography.each do |key, value|
           if key == "aliases"
              if value.length > 1  
                  puts "-#{key.capitalize} =" 
                  names= value.each{ |name| puts"~~~>#{name}."}
              elsif value.length == 1
                  puts "-#{key.capitalize} = #{value.join}"
              end
          elsif
              puts "-#{key.capitalize} = #{value}"
           end

        end
      
      when 2
        puts "*#{@superhero_instance.name}*"
        puts "3. Powerstats."
        @superhero_instance.powerstats.each do |key, value|
           puts "-#{key.capitalize} = #{value}"
        end
      
      when 3
        puts "*#{@superhero_instance.name}*"
        puts "4. Work."
        @superhero_instance.work.each do |key, value|
           puts "-#{key.capitalize} = #{value}"
        end

      end
   end
end  
 
