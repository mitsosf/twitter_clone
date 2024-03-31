defmodule BasicTwitterWeb.TweetLive.FormComponent do
  use BasicTwitterWeb, :live_component

  alias BasicTwitter.Timeline

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage tweet records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="tweet-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:content]} type="textarea" label="Tweet" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Tweet</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{tweet: tweet} = assigns, socket) do
    changeset = Timeline.change_tweet(tweet)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"tweet" => tweet_params}, socket) do
    changeset =
      socket.assigns.tweet
      |> Timeline.change_tweet(tweet_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"tweet" => tweet_params}, socket) do
    save_tweet(socket, socket.assigns.action, tweet_params)
  end

  defp save_tweet(socket, :edit, tweet_params) do
    case Timeline.update_tweet(socket.assigns.tweet, tweet_params) do
      {:ok, tweet} ->
        notify_parent({:saved, tweet})

        {:noreply,
         socket
         |> put_flash(:info, "Tweet updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_tweet(socket, :new, tweet_params) do
    case Timeline.create_tweet(tweet_params) do
      {:ok, tweet} ->
        notify_parent({:saved, tweet})

        {:noreply,
         socket
         |> put_flash(:info, "Tweet created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
