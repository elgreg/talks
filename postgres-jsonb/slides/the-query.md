##  The query

```sql
SELECT allArticles.id, allArticles.data -> 'date' AS date,
    allArticles.data #>> '{section,slug}' AS section,
    count(audioArticles.id) AS embedCount,
    array_agg(audioArticles.type) AS type,
    array_agg(audioArticles.audioArticleRef) AS refs
FROM components.article AS allArticles
LEFT OUTER JOIN (
  SELECT articles.id, split_part(obj.val ->> '_ref', '/', 3) AS type,  obj.val ->> '_ref' AS audioArticleRef
	FROM components.article AS articles
	JOIN lateral jsonb_array_elements(articles.data -> 'content') obj(val)
	ON split_part(obj.val ->> '_ref', '/', 3) IN ('audio-player', 'slate-megaphone', 'slate-audio-embed')
	WHERE articles.id LIKE '%@published'
	AND articles.data ->> 'date' > '2019-10-01T00:00:00+00:00'
) AS audioArticles
ON allArticles.id = audioArticles.id
WHERE allArticles.data ->> 'date' > '2019-10-01T00:00:00+00:00'
GROUP BY 1, 2
ORDER BY 2 ASC
```


Some tips on reading SQL

1. Case doesn't matter. as a practice folks will write special SQL words in caps like `SELECT`.

```sql
SELECT id, data
FROM components.article
```

Is the same as

```sql
select id, data
from components.article
```


2. Space doesn't matter unless it's inside quotes or tablenames (!), but there are conventions

```sql
select
id,
data
from
components.article
```

👆 please don't do this


3. You can rename things with `as` and or by just a space after them. It's confusing!

```sql
SELECT id AS stuff, data
FROM components.article
```

is the same as

```sql
SELECT id stuff, data
FROM components.article
```

👆I hate this


4. There are lots of types of joins and if you just say `join` it will imply one of them.

```sql
SELECT *
FROM pages
JOIN authors ON pages.author_id = authors.id
```

is the same as

```sql
SELECT *
FROM pages
INNER JOIN authors on pages.author_id = authors.id
```


## Broken down question again

Can you get a count of the number of articles we published each day by section since October of 2019 and how many of those articles had podcast player embeds?


## Step 1.

Can you get a count of the number of _**articles we published**_ each day by section since October of 2019 and how many of those articles had podcast player embeds?

```sql
SELECT id
FROM components.article
```


![query-001](./resources/query-001.png)


## Step 2 - Since October

Count of the number of _**articles we published**_ each day by section _**since October of 2019**_ and how many of those articles had podcast player embeds

```sql
SELECT id
FROM components.article
WHERE data ->> 'date' > '2019-10-01T00:00:00+00:00'
```

Whoa! WTF is that ->> thing! It's [JSON querying](!

* [Offical documenation](https://devhints.io/postgresql-json)
* [Cheatsheet](https://devhints.io/postgresql-json)
* [Snickel.net Querying JSON in postgres](https://schinckel.net/2014/05/25/querying-json-in-postgres/)


## Step 2 -  Results

![query-002](./resources/query-002.png)


## Step 3 - Count 'em

_**Count of the number of articles we published**_ each day by section _**since October of 2019**_ and how many of those articles had podcast player embeds


First let's look at one row of data in the results from step 2

```sql
SELECT *
FROM components.article
WHERE data ->> 'date' > '2019-10-01T00:00:00+00:00'
```

![query-003-data-row](./resources/query-003-data-row.png)


what's in `data

```json
{
    "date": "2017-02-08T19:30:20+00:00",
    "slug": "rukmini-callimachi-iraqi-troops-muslim-ban-mosul",
    "tags": {
        "_ref": "stage.slate.com/_components/tags/instances/ciyxc39kc000iignf9voi9wbp@published"
    },
    "feeds": {
        "rss": true,
        "newsfeed": true,
        "sitemaps": true,
        "most-popular": true
    },
    "rubric": "",
    "authors": [
        {
            "text": "Ben Mathis-Lilley"
        }
    ],
    "content": [
        {
            "_ref": "stage.slate.com/_components/clay-paragraph/instances/ciyxc39kc000jignf451acl1u@published"
        },
        {
            "_ref": "stage.slate.com/_components/clay-paragraph/instances/ciyxcixwv0018ignfnupvfo5w@published"
        },
        {
            "_ref": "stage.slate.com/_components/clay-paragraph/instances/ciyxcj4kj0019ignf1ib7n9m3@published"
        },
        {
            "_ref": "stage.slate.com/_components/clay-paragraph/instances/ciyxc9z68000tignfgqvf9t1a@published"
        },
        {
            "_ref": "stage.slate.com/_components/clay-paragraph/instances/ciyxcaci5000uignf4c3nmdb2@published"
        },
        {
            "_ref": "stage.slate.com/_components/slate-image/instances/ciyxceo1k0017ignf4eqlgxo5@published"
        },
        {
            "_ref": "stage.slate.com/_components/clay-paragraph/instances/ciyxc8ozw000mignfscb6imxf@published"
        },
        {
            "_ref": "stage.slate.com/_components/clay-paragraph/instances/ciyxc90y0000oignf5hto9312@published"
        },
        {
            "_ref": "stage.slate.com/_components/clay-paragraph/instances/ciyxc9ar6000qignfe7xbz9ah@published"
        },
        {
            "_ref": "stage.slate.com/_components/slate-share/instances/ciyxc39kc000kignfnvnonuew@published"
        }
    ],
    "page_id": "stage.slate.com/_components/article/instances/ciyxc39kc000lignfezmf9s0g@published",
    "headSlug": [
        "stage.slate.com/_components/clay-meta-url/instances/ciyxc39k5000eignfk30a8xmn"
    ],
    "sideSlug": [],
    "slugLock": true,
    "headImage": [
        "stage.slate.com/_components/meta-image/instances/ciyxc39k6000gignfquah2geq"
    ],
    "headTitle": [
        "stage.slate.com/_components/clay-meta-title/instances/ciyxc39k4000dignfgcu013po"
    ],
    "promoLine": "Iraqi Troops Engage in Life or Death Struggle",
    "feedImgUrl": "",
    "feedLayout": "small",
    "headAuthors": [],
    "seoHeadline": "Rukmini Callimachi: Iraqi troops anxious over Muslim ban in Mosul.",
    "canonicalUrl": "http://stage.slate.com/2017/02/rukmini-callimachi-iraqi-troops-muslim-ban-mosul.html",
    "omnitureData": "{\"rubric\":\"\",\"seoHeadline\":\"Rukmini Callimachi: Iraqi troops anxious over Muslim ban in Mosul.\",\"commericalNode\":\"undefined/\",\"pubDate\":\"2017-02-08T19:30:20+00:00\",\"tags\":{}}",
    "shareButtons": [],
    "photographers": [],
    "rubricMessage": "",
    "shortHeadline": "Troops",
    "syndicatedUrl": "",
    "seoDescription": "Iraqi troops in Mosul question Trump Muslim travel ban.",
    "headDescription": [
        "stage.slate.com/_components/clay-meta-description/instances/ciyxc39k5000fignfn0vqa1h2"
    ],
    "primaryHeadline": "Iraqi Troops Engage in Life or Death Struggle",
    "overrideHeadline": "Iraqi Troops Engage in Life or Death Struggle",
    "syndicationStatus": "original",
    "plaintextPromoLine": "Iraqi Troops Engage in Life or Death Struggle",
    "plaintextShortHeadline": "Troops",
    "plaintextPrimaryHeadline": "Iraqi Troops Engage in Life or Death Struggle"
}
```

## Step 3 - Query on date

```sql
SELECT count(id)
FROM components.article
WHERE data ->> 'date' > '2019-10-01T00:00:00+00:00'
```


# Step 3 Results

![query-003](./resources/query-003.png)




## Step 4


_**Count of the number of articles we published each day**_ by section _**since October of 2019**_ and how many of those articles had podcast player embeds



```sql
SELECT count(id), data -> 'date'
FROM components.article
WHERE data ->> 'date' > '2019-10-01T00:00:00+00:00'
```


## Step 4 Results

![query-004-error](./resources/query-004-error.png)


## Try again

```sql
SELECT count(id), data -> 'date'
FROM components.article
WHERE data ->> 'date' > '2019-10-01T00:00:00+00:00'
GROUP BY data-> 'date'
```


## Again results (Step 4)

![query-004](./resources/query-004.png)

But still not great, we only want the day! We can do dumb string things, though

```sql
SELECT LEFT("greg",2)
```


```
SELECT count(id), left(data -> 'date', 10)
FROM components.article
WHERE data ->> 'date' > '2019-10-01T00:00:00+00:00'
GROUP BY 2
```


### NOPE

![query-004-error-2.png](./resources/query-004-error-2.png)

WTF?!

It's `->` vs `->>`


```sql
SELECT count(id), left(data ->> 'date', 10)
FROM components.article
WHERE data ->> 'date' > '2019-10-01T00:00:00+00:00'
GROUP BY 2
```


## Results!

![query-004](./resources/query-004-almost.png)

## Order!

![query-004](./resources/query-004-done.png)







