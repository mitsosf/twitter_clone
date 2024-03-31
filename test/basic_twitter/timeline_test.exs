defmodule BasicTwitter.TimelineTest do
  use BasicTwitter.DataCase

  alias BasicTwitter.Timeline

  describe "tweets" do
    alias BasicTwitter.Timeline.Tweet

    import BasicTwitter.TimelineFixtures

    @invalid_attrs %{username: nil, content: nil, likes: nil, retweets: nil}

    test "list_tweets/0 returns all tweets" do
      tweet = tweet_fixture()
      assert Timeline.list_tweets() == [tweet]
    end

    test "get_tweet!/1 returns the tweet with given id" do
      tweet = tweet_fixture()
      assert Timeline.get_tweet!(tweet.id) == tweet
    end

    test "create_tweet/1 with valid data creates a tweet" do
      valid_attrs = %{username: "some username", content: "some content", likes: 42, retweets: 42}

      assert {:ok, %Tweet{} = tweet} = Timeline.create_tweet(valid_attrs)
      assert tweet.username == "some username"
      assert tweet.content == "some content"
      assert tweet.likes == 42
      assert tweet.retweets == 42
    end

    test "create_tweet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_tweet(@invalid_attrs)
    end

    test "update_tweet/2 with valid data updates the tweet" do
      tweet = tweet_fixture()
      update_attrs = %{username: "some updated username", content: "some updated content", likes: 43, retweets: 43}

      assert {:ok, %Tweet{} = tweet} = Timeline.update_tweet(tweet, update_attrs)
      assert tweet.username == "some updated username"
      assert tweet.content == "some updated content"
      assert tweet.likes == 43
      assert tweet.retweets == 43
    end

    test "update_tweet/2 with invalid data returns error changeset" do
      tweet = tweet_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_tweet(tweet, @invalid_attrs)
      assert tweet == Timeline.get_tweet!(tweet.id)
    end

    test "delete_tweet/1 deletes the tweet" do
      tweet = tweet_fixture()
      assert {:ok, %Tweet{}} = Timeline.delete_tweet(tweet)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_tweet!(tweet.id) end
    end

    test "change_tweet/1 returns a tweet changeset" do
      tweet = tweet_fixture()
      assert %Ecto.Changeset{} = Timeline.change_tweet(tweet)
    end
  end
end
