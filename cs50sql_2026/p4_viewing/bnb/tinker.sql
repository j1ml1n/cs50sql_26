SELECT
    "id",
    "listing_id",
    COUNT("id") AS 'number_reviews'
FROM reviews
GROUP BY "listing_id"
LIMIT 15;
