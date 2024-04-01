defmodule BasicTwitterWeb.TweetLive.Index do
  use BasicTwitterWeb, :live_view

  alias BasicTwitter.Timeline
  alias BasicTwitter.Timeline.Tweet

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Timeline.subscribe()
    {:ok, stream(socket, :tweets, Timeline.list_tweets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Tweet")
    |> assign(:tweet, Timeline.get_tweet!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Tweet")
    |> assign(:tweet, %Tweet{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tweets")
    |> assign(:tweet, nil)
  end

  @impl true
  def handle_info({BasicTwitterWeb.TweetLive.FormComponent, {:saved, tweet}}, socket) do
    {:noreply, stream_insert(socket, :tweets, tweet)}
  end

  @impl true
  def handle_info({:tweet_updated, tweet}, socket) do
    {:noreply, stream_insert(socket, :tweets, tweet)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tweet = Timeline.get_tweet!(id)
    {:ok, _} = Timeline.delete_tweet(tweet)

    {:noreply, stream_delete(socket, :tweets, tweet)}
  end
end
