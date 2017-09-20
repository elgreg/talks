Docker that let's us manipulate cache
headers on the way out.

What does a basic .html file do
How about an image tag?
How about a script tag?
What are options you can add to tags themselves that control caching?
What about cache manifest?
What about a service worker?

Can you turn off Etags?



Make a server that is updating a clock every second so that we can see if/when things change.

I could also change colors randomly based on the time.

Every page can always have a "definitely no cache ever" iframe that helps us keep track of what things _should_ look like at any given moment


How do we demo the CSS, JS, HTML inconsistency problem?




WHat _is_ caching?

What is a good metaphor for all the different types of caching that we have going on?



Caching is like Bub and Pops

If you made all the ingredients of the sandwich at the moment people ordered them, the line would be even longer.

What if you you:

1. Had some things ready to start
2. Had the things that are personalized added later
3. Had the things that are the same for everyone ready ahead of time.


Today, we're going to make a Bub and Pops fried chicken cutlet sandwich, but with a website.

Bread: long cache. Can do that the night before and it stays good all day.
Cut Chicken: Long cache. Might need thawing?
Fry Chicken Cutlet: Lasts about 15 minutes
Arugala: Some people don't want this. You can cut it and have it ready, but you might not want to add it to the request until later
Tomato sa
Cheese: Shred it ahead of time, but you can't add that until you have a hot chicken cutlet to melt it onto.
Paper: Super long cache. All sandwiches get wrapped.
Bag: Super long cache. Customer may not want it.

Combine, wrap, cut, bag.

Ideas... have the various things change color randomly.

Have a counter in a no-cache iframe
