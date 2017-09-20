Let's Talk About Caching!


Types of Caching that we experience day-to-day in web development (as distinguished from the caches on your computer L1, L2, etc)


To understand Cache, one first must understand the internet and how a request is routed to the computer that tells it what what to do.

Request -> ... <- Response

Layers and layers and layers


If you think about pictures  on a thumbdrive instead of the internet, you double-click a file (request) and your computer looks up its address in the file system and then shows it to you.

The internet is similar.


Start with a URL

https://slate.com

slate.com -> DNS

DNS - at Slate is in the server room. That could be cached.
It sends a response that tells your computer that slate.com is actually one of

slate.com.		50	IN	A	151.101.66.49
slate.com.		50	IN	A	151.101.130.49
slate.com.		50	IN	A	151.101.194.49
slate.com.		50	IN	A	151.101.2.49

This Fastly! Fastly is a CDN or "Content Delivery Network"

