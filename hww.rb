require 'romato'
require 'tty-prompt'
require 'tty-table'
require 'tty-spinner'

puts "Hey there! Welcome to Healthy, Wealthy and Wise! Healthy, wealthy and wise is a super cool app that will give indecisive eaters healthy restaurant recommendations using the wisdom of hundred of reviewers. We will ask you for your city, your budget and how fancy you want your food to be in order to generate your suggestions! \n \n "
prompt = TTY::Prompt.new
ready2start = prompt.select("Are you ready to start?!", %w(YES!))


# #Gathering user location selection
cities = {
Melbourne: "259",
Sydney: "260",
Brisbane: "298",
Canberra: "313",
Adelaide: "297",
Perth: "296"}
user_city = prompt.select("Select your city:", %w(Melbourne Sydney Brisbane))
puts "\n#{user_city}\n"
city = cities[user_city.to_sym]

#gathering data for 100 restaurants based on the user's location selection
def hundred_restaurants_at_location(city)
    spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :pulse_2)
    call_zomato_api = Romato::Zomato.new("ab025d4bd06e3e631940cb7a13c4f11a")
    hundred_restaurants = []
    start = 0
    count = 20
    spinner.run do |spinner|
        while hundred_restaurants.length() != 100
            spinner.run do |spinner|
                all_viable_restaurants = call_zomato_api.get_search({entity_id:city, entity_type: 'city', cuisines: "143", start:start, count:count})
                all_viable_restaurants["restaurants"].each do |restaurant|
                    hundred_restaurants << restaurant
                end
            end
            start += 20
        end
    end
    return hundred_restaurants
end

#For all 100 restaurants, keeping only the restaurants: Name, location, average cost for two, and the user rating
def keep_necessary_data(hundred_restaurants)
    good_data = {}
    count = 0
    while count != 100
        restaurant_hash = {}
        restaurant_hash[:location] = hundred_restaurants[count]["restaurant"]["location"] 
        restaurant_hash[:average_cost_for_two] = hundred_restaurants[count]["restaurant"]["average_cost_for_two"] 
        restaurant_hash[:cuisines] = hundred_restaurants[count]["restaurant"]["cuisines"] 
        restaurant_hash[:zomato_rating] = hundred_restaurants[count]["restaurant"]["user_rating"]["aggregate_rating"]
        good_data[ (hundred_restaurants[count]["restaurant"]["name"]).to_sym ] = restaurant_hash
        count += 1
    end
    return good_data
end

def filter_by_user_preferences(good_data)
    prompt = TTY::Prompt.new

    #STORING FINAL FILTERED DATA 
    final_restaurant_recommendations = {}

    #ASK USER FOR PREFERENCES
    user_budget = prompt.select("\n Select your budget:", %w(Cheap Moderate Expensive))
    puts "\n#{user_budget}\n"
    price_thresholds = {'Cheap' => 30, 'Moderate' => 60, 'Expensive' => 5000}

    user_rating = prompt.select("\n What quality of food are you looking for?", ['Excellent', 'Very good or above', 'Good or above', 'Average or better'])
    puts "\n#{user_rating}\n"
    rating_thresholds = {'Excellent' => 4.5, 'Very good or above' => 4.0, 'Good or above' => 3.5, 'Average or better' => 3.0}


    #FOR EACH RESTAURANT, VALIDATE THAT IT FULFILLS THE USER SELECTION CRITERIA
    good_data.each do |restaurant, restaurant_info|
        price_validated = price_thresholds[user_budget] >= restaurant_info[:average_cost_for_two]
        rating_validated = rating_thresholds[user_rating] <= restaurant_info[:zomato_rating].to_f

        #IF USER PRICE AND RATING ARE BOTH VALIDATED AS "TRUE", ADD RESTAURANT TO THE FINAL FILTERED DATA HASH
        if price_validated and rating_validated
            final_restaurant_recommendations[restaurant.to_sym] = restaurant_info
        end
    end
    return final_restaurant_recommendations
end

#Returning a restaurant from the suggestions hash and allowing the user to either accept or reject this restaurant offer
final_restaurant_recomendations = filter_by_user_preferences(keep_necessary_data(hundred_restaurants_at_location(city)))

def choose_a_restaurant(final_restaurant_recomendations)
    if final_restaurant_recomendations.length() != 0
        prompt = TTY::Prompt.new
        understand_rules = prompt.select("\n \n \n Now we will present you with some restaurant recommendations that fit your requirements! You can either accept or reject the selection. \n \n \n", ["Got it! Show me the foooood!"])

        question = "reject"
        while question == "reject"
            final_restaurant_recomendations.each do |restaurant_name, restaurant_info|
                if question == "accept"
                    break
                elsif question == "reject"
                    
                    #Creating a table with the restaurant data
                    table = TTY::Table.new [["", "#{restaurant_name}", ""], 
                    ["", "Serves #{restaurant_info[:cuisines]}", ""], 
                    ["", " ", ""], 
                    ["", "$#{restaurant_info[:average_cost_for_two]} for two", ""],
                    ["", "#{restaurant_info[:zomato_rating]} Stars", ""],
                    ["", " ", ""],
                    ["", "#{restaurant_info[:location]["address"]}", ""]]
                    puts table.render(:ascii, multiline: true, alignment: [:center])
                    question = prompt.select("Do you accept or reject this recommendation?", %w(accept reject))
                end
            end
            if question == "reject" 
                prompt.select("You really are a fussy eater! But seriously... you have to pick one. \n \n", ["Okay, fine, I'll pick one! Show me my options again!"])
            else
                table = TTY::Table.new [["", "Good choice!", ""], 
                ["", "Enjoy your meal!", ""]]
                puts table.render(:ascii, multiline: true, alignment: [:center])
            end
        end
    else
        puts 'Hmmm seems there are no restaurants matching your criteria! Try starting from the beginning.'
    end
end

puts choose_a_restaurant(final_restaurant_recomendations)