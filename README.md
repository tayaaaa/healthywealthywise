# Terminal App 
### Healthy, Wealthy & Wise

## Contributors
https://github.com/tayaaa | https://github.com/jtrader |
|-----------|-----------|
| Taya Lacey | Jack Oswald |

## Purpose 

Healthy, Wealthy and Wise asks users simple questions to match them with a healthy local restaurant recommendation, the recommendation comes with the restaurants name, address, cuisines they provide and also an aggregate review rating from previous diners, the user can either select to accept or reject the recommendation, if rejected they receive a new recommendation, one at a time.

## User Story

We picture users of Healthy Wealthy & Wise are health conscious indecisive eaters looking to try something new in their city.

## Functionality 

The user is prompted for their preferences:

1. Location: Users can select Healthy restaurants from major cities Australia wide.

2. Price: Users can select from a variety of price points (Cheap, Moderate, Expensive)

3. Rating: Users decided whether they want food that is rated: Excellent, Very Good, Good or Average. 

4. The app suggests a restaurant and gives the user a choice to either accept or reject, if rejected the user provided with another restaurant.

## Dependencies

The Ruby gems 'tty-prompt', 'tty-spinner', 'romato' and 'tty-table' ' are required to run Healthy Wealthy & Wise.

The terminal app relies on API pull requests from leading restaurant review site zomato.com.au. 

![alt text](https://content.screencast.com/users/Jack_Oswald/folders/Jing/media/9059c4e2-556b-4265-8c99-cb3faec5425e/00000004.png)

```ruby
require "romato"
zomato_instance = Romato::Zomato.new('ac5e47026c2bc94d0a451ce4fa196b7b')
```



## Instructions for Use
Download source code, and save to preferred directory.

Open terminal and navigate to the directory where you have saved Healthy Wealty & Wise.

Install the pre-requisite gems with the following code:

```ruby 
$ gem install 'tty-prompt'
$ gem install 'tty-table'
$ gem install 'romato'
$ gem install 'tty-spinner'
```
To initialize program enter the following:

```ruby 
$ ruby hww.rb
```
Follow the program prompts!

## Task Management

We were able prioritise and manage tasks from our trello board while noting primary tasks to fulfil the requirements for minimum viable product. We were able to split coding tasks into mini-project deliverables, ie methods etc Given time restraints we prioritised tasks to ensure a minimum viable product was produced.

![alt text](https://content.screencast.com/users/Jack_Oswald/folders/Jing/media/eaf1e130-4af5-40a4-a3f9-190e39fe92d2/00000003.png "Trello Board")

# Designing and Planning

## Brainstorming
Brainstorming
![alt text](https://content.screencast.com/users/Jack_Oswald/folders/Jing/media/fbab5076-f8fd-4040-a24e-a5c139452351/00000007.png "Brainstorming")

Data Flow
![alt text](https://content.screencast.com/users/Jack_Oswald/folders/Jing/media/39d88f39-5bb5-4db2-a3db-7a0845e4a976/00000005.png "Sketch")

Problem Solving
![alt text](https://content.screencast.com/users/Jack_Oswald/folders/Jing/media/5e8562e6-4a6f-455d-aca6-ebe3105d2a51/00000006.png "Problem Solving")

## User Journey/Workflow 

![alt text](https://content.screencast.com/users/Jack_Oswald/folders/Jing/media/81894c30-9cc3-401f-8e23-e63dcc40a9a6/00000009.png "User Flow")


## Coding Process

Initially we explored the features of the zomato.com.au API which would provide us with data to achieve the goals of the terminal app. This included ascertaining which data would be required from the API and how we would work with it. We noticed that not all data provided on the Zomato website would be available through the API. Once we recognised what could be utilised we went about fetching that data via ruby.

We initially fetched the data based on the user's preferred location. We then sorted this data into a useful format (A Hash of restaurant Hashes) and kept only the relevant information for our app, for example discarded image urls etc We then passed that information through an additional method based on the user's budget and rating preferences. Returning the user with a selection of results displayed to them one at a time. We gave the user the option of 'Reject' or 'Accept' a restaurant recommendation, if rejected the user would be given another recommendation iterating through a loop. If accepted we give the user a "Enjoy your meal" message and are satisfied they have successfully utilised the app.


## Timeline
### Day One
- Brainstorm app concept 
- Scoping API abilities 
- Refining concept based on restraints (API)
- Fetching data into useful format

### Day Two
- Gathered user input
- Wrote methods to filter restaurants based on user preferences
- Refactored, Formatted and Debugged Code
- Tested Code

## Challenges
- Dealing with API constraints eg. No restaurant description
- Understanding complex data structure and refactoring into workable format
- API limited to 20 data instances per call, we had to recall 5 times to build restaurant data (with a total limit of 100)
- Taking into consideration the matrix of user input possibilities
- We noticed different treatment of API data for different locations(cities)

## Future Enhancements 
- Geo Location (able to recognise the users location via IP)
- Reviews 
- Scalability across different cuisines

## Ethics 
Due to the general nature of the application ethical considerations are minimal. Because the app is terminal, it's restricted to a very small portion of the population who know how to run a terminal, even though we have provided very good instructions on how to install and run the app.
