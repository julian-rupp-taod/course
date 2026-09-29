WITH reviews AS (
    SELECT
        listing_id,
        MIN(review_date) AS min_review_date
    FROM {{ ref('fct_reviews') }}
    GROUP BY listing_id
),

listings AS (
    SELECT
        listing_id,
        created_at AS listing_created_at
    FROM {{ ref('dim_listings_cleansed') }}
)

SELECT
    r.listing_id,
    r.min_review_date,
    l.listing_created_at
FROM reviews AS r
INNER JOIN listings AS l
ON r.listing_id = l.listing_id
WHERE r.min_review_date < l.listing_created_at
