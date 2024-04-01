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
                  <a href="#" class="w-12 mt-1 group flex items-center text-gray-500 px-3 py-2 text-base leading-6 font-medium rounded-full hover:bg-blue-800 hover:text-blue-300">
                    <svg class="text-center h-7 w-6" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" stroke="currentColor" viewBox="0 0 24 24"><path d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path></svg>
                  </a>
                </div>
                <div>
                  <span><%= @tweet.retweets%></span>
                </div>
                <div class="flex-1 text-center py-2 m-2">
                  <a href="#" class="w-12 mt-1 group flex items-center text-gray-500 px-3 py-2 text-base leading-6 font-medium rounded-full hover:bg-blue-800 hover:text-blue-300">
                    <svg class="text-center h-7 w-6" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" stroke="currentColor" viewBox="0 0 24 24"><path d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4"></path></svg>
                  </a>
                </div>
                <div class="flex-1 text-center py-2 m-2">
                  <.link
                    phx-click={JS.push("delete", value: %{id: @tweet.id}) |> hide("tweets-#{@id}")}
                    data-confirm="Are you sure?"
                    class="w-12 mt-1 group flex items-center text-gray-500 px-3 py-2 text-base leading-6 font-medium rounded-full hover:bg-blue-800 hover:text-blue-300"
                  >
                      <svg fill="#000000" version="1.1" id={"Capa_1-#{@id}"} xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 482.428 482.429" xml:space="preserve"><g id={"SVGRepo_bgCarrier-#{@id}"} stroke-width="0"></g><g id={"SVGRepo_traceCarrier-#{@id}"} stroke-linecap="round" stroke-linejoin="round"></g><g id={"SVGRepo_iconCarrier-#{@id}"}> <g> <g> <path d="M381.163,57.799h-75.094C302.323,25.316,274.686,0,241.214,0c-33.471,0-61.104,25.315-64.85,57.799h-75.098 c-30.39,0-55.111,24.728-55.111,55.117v2.828c0,23.223,14.46,43.1,34.83,51.199v260.369c0,30.39,24.724,55.117,55.112,55.117 h210.236c30.389,0,55.111-24.729,55.111-55.117V166.944c20.369-8.1,34.83-27.977,34.83-51.199v-2.828 C436.274,82.527,411.551,57.799,381.163,57.799z M241.214,26.139c19.037,0,34.927,13.645,38.443,31.66h-76.879 C206.293,39.783,222.184,26.139,241.214,26.139z M375.305,427.312c0,15.978-13,28.979-28.973,28.979H136.096 c-15.973,0-28.973-13.002-28.973-28.979V170.861h268.182V427.312z M410.135,115.744c0,15.978-13,28.979-28.973,28.979H101.266 c-15.973,0-28.973-13.001-28.973-28.979v-2.828c0-15.978,13-28.979,28.973-28.979h279.897c15.973,0,28.973,13.001,28.973,28.979 V115.744z"></path> <path d="M171.144,422.863c7.218,0,13.069-5.853,13.069-13.068V262.641c0-7.216-5.852-13.07-13.069-13.07 c-7.217,0-13.069,5.854-13.069,13.07v147.154C158.074,417.012,163.926,422.863,171.144,422.863z"></path> <path d="M241.214,422.863c7.218,0,13.07-5.853,13.07-13.068V262.641c0-7.216-5.854-13.07-13.07-13.07 c-7.217,0-13.069,5.854-13.069,13.07v147.154C228.145,417.012,233.996,422.863,241.214,422.863z"></path> <path d="M311.284,422.863c7.217,0,13.068-5.853,13.068-13.068V262.641c0-7.216-5.852-13.07-13.068-13.07 c-7.219,0-13.07,5.854-13.07,13.07v147.154C298.213,417.012,304.067,422.863,311.284,422.863z"></path> </g> </g> </g></svg>
                  </.link>
                </div>
              </div>
            </div>
          </div>
        </div>
        <hr class="border-gray-600">
      </div>
    """
  end
end