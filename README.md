OpenTweet
=========

@Olivier:

Updates
-------

* Dates fixed (well I'm assuming I don't have to worry about converting to UTC since more appropriate to display local time?)
* Autolayout fixed
* Tweet threads added
* Highlighted mentions in tweets
* Avatars added

But it has bugs.. :P
--------------------

* When testing on my device, I noticed that sometimes when a cell scrolls into view, the spacing/height of the cell is larger than it should be, until I scroll out of view and back into view of the buggy cell, at which point the spacing/height of the cell is fixed
* When I scroll really fast, sometimes an avatar shows up within the wrong cell, and then after a short period of time it corrects itself
* The spacing from the test within a cell to the top of the cell and the spacing from the test within a cell to the bottom of the cell are not perfectly equal size, need to fix this

Remarks
-------

* Right now, if a tweet is replying to another tweet, but it also has a new thread starting from it, I display choose to display the tweet and the thread it is replying to only
* To be honest, I got the background thread to work, but still don't completely understand how blocks work.. I will do my research to gain a better understanding
* To be honest, not that familiar with xctest either, but found good documentation on it so I will read up
* I had to stop working on this because I ended up getting busier this weekend (had work at the restaurant both Sat and Sun, and had school assignments) and didn't have time to add tests and fix the bugs I mentioned above :/ If you would like to see more, could I continue working on this after my finals this week?

Thanks! such app, much enjoyed

Patricia

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
