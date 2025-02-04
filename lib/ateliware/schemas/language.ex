defmodule Ateliware.Schemas.Language do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  alias Ateliware.Repo
  alias Ateliware.Schemas.GithubRepo
  alias __MODULE__, as: Language

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "languages" do
    field :color, :string
    field :name, :string, unique: true
    field :display_name, :string

    has_many :github_repos, GithubRepo, foreign_key: :language_id, references: :id

    timestamps()
  end

  @doc false
  def changeset(attrs) do
    %Language{}
      |> cast(attrs, [:display_name, :name, :color])
      |> validate_required([:display_name, :name, :color])
  end

  @spec get_languages :: [Language]
  def get_languages do
    Repo.all(Language)
  end
end
