defmodule BasicTwitter.TimelineFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BasicTwitter.Timeline` context.
  """

  @doc """
  Generate a tweet.
  """
  def tweet_fixture(attrs \\ %{}) do
    {:ok, tweet} =
      attrs
      |> Enum.into(%{
        content: "some content",
        likes: 42,
        retweets: 42,
        username: "some username"
      })
      |> BasicTwitter.Timeline.create_tweet()

    tweet
  end
end
