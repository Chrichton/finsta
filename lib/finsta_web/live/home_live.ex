defmodule FinstaWeb.HomeLive do
  use FinstaWeb, :live_view

  alias Finsta.Posts
  alias Finsta.Posts.Post

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    form =
      %Post{}
      |> Post.changeset(%{})
      |> to_form(as: "post")

    socket =
      socket
      |> assign(form: form)
      |> allow_upload(:image, accept: ~w(.png .jpeg), max_entries: 1)

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <h1 class="text-2xl">Finsta</h1>

    <.simple_form for={@form} phx-submit="save_post" phx-change="validate">
      <.live_file_input upload={@uploads.image} required />
      <.input field={@form[:caption]} type="textarea" label="Caption" required />

      <.button type="submit" phx-disable-with="Saving...">Create Post</.button>
    </.simple_form>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("validate", _unsigned_params, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("save_post", %{"post" => post_params}, socket) do
    %{current_user: user} = socket.assigns

    post_params
    |> Map.put("user_id", user.id)
    |> Map.put("image_path", hd(consume_files(socket)))
    |> Posts.save()
    |> case do
      {:ok, _post} ->
        socket =
          socket
          |> put_flash(:info, "Post created successfully")
          |> push_navigate(to: ~p"/home")
          |> IO.inspect()

        {:noreply, socket}

      {:error, changeset} ->
        socket =
          socket
          |> put_flash(:error, changeset)

        {:noreply, socket}
    end

    {:noreply, socket}
  end

  def consume_files(socket) do
    consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
      dest = Path.join(Application.app_dir(:finsta, "priv/static/uploads"), Path.basename(path))

      File.cp!(path, dest)
      {:postpone, ~p"/uploads/#{Path.basename(dest)}"}
    end)
  end
end
