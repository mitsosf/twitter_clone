defmodule BasicTwitterWeb.TweetLive.TweetComponent do
  use BasicTwitterWeb, :live_component

  def render(assigns) do
    ~H"""
      <div id={"tweets-#{@id}"}>
        <div class="flex flex-shrink-0 p-4 pb-0">
          <a href="#" class="flex-shrink-0 group block">
            <div class="flex items-center">
              <div>
                <img class="inline-block h-10 w-10 rounded-full" src="https://frangiadakis.com/static/c9a327a1b654a8d1b88b85399ecf7551/89f4f/profile.jpg" alt="" />
              </div>
              <div class="ml-3">
                <span class="text-sm leading-5 font-medium text-black-400 group-hover:text-gray-300 transition ease-in-out duration-150">
                  @<%= @tweet.username %> . <%= @tweet.inserted_at.year %>.<%= @tweet.inserted_at.month %>.<%= @tweet.inserted_at.day %> <%= @tweet.inserted_at.hour %>:<%= @tweet.inserted_at.minute %>
                  </span>
              </div>
            </div>
          </a>
        </div>
        <div class="pl-16">
          <p class="text-base width-auto font-medium text-black flex-shrink">
            <%= @tweet.content %>
          </p>
          <div class="flex">
            <div class="w-full">
              <div class="flex items-center">
                <div>
                  <span>   <%= @tweet.likes%></span>
                </div>
                <div class="flex-1 text-center py-2 m-2">
                  <a href="#" phx-click="like" phx-target={@myself} class="w-12 mt-1 group flex items-center text-gray-500 px-3 py-2 text-base leading-6 font-medium rounded-full hover:bg-blue-800 hover:text-blue-300">
                    <svg class="text-center h-7 w-6" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" stroke="currentColor" viewBox="0 0 24 24"><path d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path></svg>
                  </a>
                </div>
                <div>
                  <span><%= @tweet.retweets%></span>
                </div>
                <div class="flex-1 text-center py-2 m-2">
                  <a href="#" phx-click="retweet" phx-target={@myself} class="w-12 mt-1 group flex items-center text-gray-500 px-3 py-2 text-base leading-6 font-medium rounded-full hover:bg-blue-800 hover:text-blue-300">
                    <svg class="text-center h-7 w-6" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" stroke="currentColor" viewBox="0 0 24 24"><path d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4"></path></svg>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <hr class="border-gray-600">
      </div>
    """
  end

  def handle_event("like", _, socket) do
    tweet = BasicTwitter.Timeline.get_tweet!(socket.assigns.tweet.id)
    new_likes = tweet.likes + 1
    BasicTwitter.Timeline.update_tweet(socket.assigns.tweet, %{likes: new_likes})
    {:noreply, socket}
  end

  def handle_event("retweet", _, socket) do
    tweet = BasicTwitter.Timeline.get_tweet!(socket.assigns.tweet.id)
    new_retweets = tweet.retweets + 1
    BasicTwitter.Timeline.update_tweet(socket.assigns.tweet, %{retweets: new_retweets})
    {:noreply, socket}
  end
end