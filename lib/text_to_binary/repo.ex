defmodule TextToBinary.Repo do
  use Ecto.Repo,
    otp_app: :text_to_binary,
    adapter: Ecto.Adapters.Postgres
end
