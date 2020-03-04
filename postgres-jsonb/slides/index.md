
# Querying Postgres JSONB

Part 1

----

## Part 1,715

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
