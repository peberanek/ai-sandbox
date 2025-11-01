"""A simple script that classifies sentiment of tweets from a CSV file.

This script reads tweets from tweets.csv and uses an OpenAI-compatible API
to classify the sentiment of each Czech tweet as positive, negative, or neutral.
Results are printed to stdout with the tweet ID and sentiment classification.
"""

import os
import openai
from pandas import read_csv


def main():
    client = openai.OpenAI(
        api_key=os.environ["GATEWAY_API_KEY"],
        base_url=os.environ["GATEWAY_URL"],
    )
    data_frame = read_csv("tweets.csv")
    system_prompt = """
You are a sentiment classification assistant. Classify the sentiment of each
tweet written in Czech as one of: positive, negative, or neutral. Only reply
with the label.
"""

    for _, row in data_frame.iterrows():
        messages = [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": row["tweet_text"]},
        ]
        response = client.chat.completions.create(
            model="e-infra/gpt-oss-120b",
            messages=messages,
            temperature=0,
        )
        print(f"{row['tweet_id']}, {response.choices[0].message.content}")


if __name__ == "__main__":
    main()
