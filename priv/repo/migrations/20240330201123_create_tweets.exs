defmodule BasicTwitter.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :username, :string
      add :content, :string
      add :likes, :integer
      add :retweets, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
