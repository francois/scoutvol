class Avo::Resources::Event < Avo::BaseResource
  self.search = {
    query: -> {
      query.ransack(
        id_eq: params[:q],
        slug_i_cont: params[:q],
        title_i_cont: params[:q],
        m: "or"
      ).result(distinct: false)
    }
  }

  self.title = :title

  def fields
    field :id, as: :id
    field :season_id, as: :number
    field :title, as: :text
    field :slug, as: :text, hide_on: :forms
    field :start_at, as: :date_time
    field :max_registrations, as: :number
    field :season, as: :belongs_to
    field :registrations, as: :has_many
    field :attendances, as: :has_many
  end
end
