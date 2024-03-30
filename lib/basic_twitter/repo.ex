defmodule BasicTwitter.Repo do
  use Ecto.Repo,
    otp_app: :basic_twitter,
    adapter: Ecto.Adapters.Postgres
end
