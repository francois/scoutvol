class Avo::Resources::Season < Avo::BaseResource
  self.search = {
    query: -> {
      query.ransack(
        id_eq: params[:q],
        slug_i_cont: params[:q],
        name_i_cont: params[:q],
        m: "or"
      ).result(distinct: false)
    }
  }

  self.title = :name
  self.external_link = -> { main_app.registrations_path(season_slug: record.slug) }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :slug, as: :text, hide_on: :forms
    field :events, as: :has_many
  end
end
