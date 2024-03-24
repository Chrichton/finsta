# Finsta

# Installation

- mix archive.install hex phx_new
- mix phx.new finsta
- mix phx.gen.auth Accounts User users
- mix phx.gen.schema Posts.Post posts caption:text image_path:string user_id:references:users

#Learned

- ~p"" -> Phoenix.VerifiedRoutes.sigil_p(
  route,
  extra
  )

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
