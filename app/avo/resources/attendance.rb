class Avo::Resources::Attendance < Avo::BaseResource
  self.search = {
    query: -> {
      query.ransack(
        id_eq: params[:q],
        person_name_i_cont: params[:q],
        m: "or"
      ).result(distinct: false)
    }
  }

  self.title = :person_name

  def fields
    field :id, as: :id
    field :event_id, as: :number
    field :slug, as: :text, hide_on: :forms
    field :person_name, as: :text
    field :branch, as: :text
    field :attended_at, as: :date_time
    field :event, as: :belongs_to
  end
end
