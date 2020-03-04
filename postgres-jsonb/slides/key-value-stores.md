##  key-value stores

Key value stores (somtimes called NoSQL databases) are another kind of list. Examples are Redis, MongoDB, CouchDB, ElasticSearch (debatable) and many, many, more.


In key-value stores, you just have ID and then a value. Some support the _concept_ of joining, but it's not the same as querying a relational database and invovles stages of processing.


WHY?

* They are much easier to scale. If you only need the key to get the data, it's easy to add more space. They don't all need to be collocated to talk to each other.
* They're faster. Looking up a single key is a lot easier than looking up the page and then the author to get the name
* Each object is its own thing. With no contstraints and no relationships, you aren't stuck having to do lots of complicated data migrations.
* Of course, this 👆 also means it's hard to actually rely on any data being there.
