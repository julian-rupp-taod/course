from textblob import TextBlob

def get_sentiment(text):
    return TextBlob(text).sentiment.polarity

def model(dbt, session):
    dbt.config(
        materialized="table",
        packages=["textblob", "snowflake-connector-python[pandas]"]
    )

    reviews = dbt.ref("fct_reviews")
    df = reviews.to_pandas()

    df["SENTIMENT_SCORE"] = df["REVIEW_TEXT"].apply(get_sentiment)

    return df