defmodule Finsta.Posts do
  alias Finsta.Posts.Post
  alias Finsta.Repo

  def save(post_params) do
    IO.inspect(post_params)

    %Post{}
    |> Post.changeset(post_params)
    |> Repo.insert()
  end
end
