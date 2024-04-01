defmodule BasicTwitter.Timeline.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tweets" do
    field :username, :string, default: "Anonymous"
    field :content, :string
    field :likes, :integer, default: 0
    field :retweets, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:content, :likes, :retweets])
    |> validate_required([:content, :likes, :retweets])
    |> validate_length(:content, min: 1, max: 280)
  end
end
