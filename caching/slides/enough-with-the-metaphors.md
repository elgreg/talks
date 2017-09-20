##  Enough with the metaphors

Let's talk about all the different layers of caching


In a typical highly scaled web application, you may find cached versions of assets (images, css, js, html, etc) and data (e.g. the json list of articles you should see next) at the following layers:


### Browser memory

This is what's disabled when you check off "disable cache" in Chrome


### Service workers


### Browser HTTP Cache


### HTTP Push Cache


### DNS requests


### Your ISP


### CDNs (Akamai / Fastly / Cloudfront) and other Proxies


### The Application Itself

#### Server Memory | Network Memory (Redis)


### What about the APIs that the application calls?

How long does Parsely cache its responses? Panoply?



## This is why cache invalidation is so hard!!

> There are two hard things in computer science: cache invalidation, naming things -- [Phil Karlton](https://twitter.com/timbray/status/506146595650699264)


### DEMO

Let's talk about the Browser and the Cache-Control header

