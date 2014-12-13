OpenTweet
=========

@Olivier:

Note: This is just my first submission, just so you have something to look at, but it's still missing the basic requirement to scale to different sized devices (try running with iPhone 5s or iPhone 6, these work best for now). I am still working on figuring out how to set these layout constraints correctly. Will give you an update.

Features I added:

* I added storyboard just cuz it’s what I’m used to, although I have a familiarity with nibs too.

* I also embedded TimeLineViewController in a NavigationController (will help later when I need to pop a ViewController off the stack)

* I created two helper methods to help with 1) calculating the date, and 2) calculating the height for the multiline text

* I tagged all my comments with my initials 'PSD' so they are easy for you to search for

Next line of action:

* Continue working on layout constraints

* Bonus feature: segue to new ViewController with Tweet threads

* Bonus feature: maybe dispay the author's avatar when user clicks author's name? or have avatar appear in tableview cell itself

* Bonus feature: display attached images 

Last remarks: If I missed any other basic features that you wanted to see, please let me know. (I still have yet
to add to the test file)

----------------------------------------------------------------------------------------------------------------

Hi Patricia! Welcome to your iOS coding excercise.

The purpose of the excercise is to gauge your ability to catch up on UIKit skills. This is a very simple twitter like client. You'll find a json file under Data/ with a short tweet timeline. You are asked to write the app that will display the tweets, similar to what a Twitter client would do.

A tweet has at the minimum:

* An id
* An author
* A content (e.g. the actual tweet)
* A date (text format, in the standard ISO-88601 format)

Additionally, a tweet may have:

* A reference to the tweet ID it's replying to
* A URL to the user's avatar
* A list of image URLs

The timeline is a chronologically ordered (ascending order) list of tweets.

Since the topic is very simple, yet offers so many possibilities at the same time, there is a minimum requirement, and bonuses.

Minimum requirement
-------------------

* Fork the repo
* Parse the json file included in the project
* Display the tweets in the order the json file defines them. The app should display the author, the tweet and the date it was tweeted at. Tweets are variable length, so the cells must be properly sized to the content
* When done, send a pull request to this project (e.g don't email me your project :))

Bonuses (in no particular order)
-------

* Highlight the mentions (@username) and/or links in a different font/color
* Display a tweet's thread when tapping on a giving tweet. Due to the very simplistic data model made available to you, it's probably best to simplify this: if the user taps on the first tweet of a thread, display all the replies in ascending chronological order, if the user taps on a reply to another tweet, only show the tapped tweet and the tweet it's replying to.
* Display attached images (networking calls are somewhat off topic though)
* Display the user's avatar (this one is quite hard, because of text reflowing)
* Animate/highlight a tweet when it is selected (e.g. make it "bigger", in an animated fashion)
* Anything else you might think of that showcases a UIKit feature: UIDynamics, parallax effect, the list is endless.

What the assignment will be judged on
-------------------------------------

* Accuracy of the result (e.g. is the cell sizing pixel perfect, dates are properly formatted, the app doesn't crash, project builds and runs with no extra step, etc.)
* Proper usage of UIKit apis (e.g. are cells properly reused, a back button must have a proper title, how well does it scale to 3.5/4/4.7 inch devices, etc.)
* Overall code quality: clarity, conciseness, quality of comments.
* If you end up short on time and/or can't fix a specific bug or finish a given feature, update this readme with what the bug is, and how you think you can fix had you more time.
* Bonuses are exactly that, bonuses. If you can complete one or more, good. Otherwise, don't sweat it

What the assignment will NOT be judged on
-----------------------------------------

* Visual design. this is a UI coding excercise, not a visual design excercise. Feel free to use Comic Sans 48 pts with green on red text if you feel like it (just warn me if you do so, so I can put sunglasses on before running the app :))
* UI performance (e.g. framerate), as long as it's reasonable. Feel free to indicate in the code if/why something would affect the framerate, and a potential solution to it.
* If you try to complete a bonus and can't finish it, that's fine. I'd recommend using git commits/tags to indicate where the bonuses start in the history, so we can easily reset the branch at that commit and validate the minimum requirement.

General advice
--------------

* I'd recommend against creating a domain model for the tweets (e.g. having a Tweet class, an Author class, etc.). Object design is infamously hard to get done right, and that's not what we're testing here. Passing around an NSArray of NSDictionnaries is perfectly fine.
* I'd strongly recommend using a UITableView and auto layout, but that is ultimately up to you (learning curve can be steep on autolayout, and manual layout is very manageable at this complexity level)
* Don't bite more than you can chew. You are not expected to be a UIKit expert, you're better off nailing the basics than failing more complex features
* If you can't complete something, explain why, how you reached that conclusion and potential options to complete it.

Happy coding!

![All the things](http://cdn.meme.am/instances/500x/57104950.jpg)
