class Avo::Resources::Registration < Avo::BaseResource
  self.search = {
    query: -> {
      query.ransack(
        id_eq: params[:q],
        person_name_i_cont: params[:q],
        registration_email_i_cont: params[:q],
        m: "or"
      ).result(distinct: false)
    },
    item: -> {
      {
        title: "#{record.person_name} / #{record.event.title}"
      }
    }
  }

  self.includes = %i[event]
  self.title = :person_name

  def fields
    field :id, as: :id
    field :event_id, as: :number
    field :slug, as: :text, hide_on: :forms
    field :person_name, as: :text
    field :registration_email, as: :text
    field :branch, as: :select, options: BRANCH_NAMES
    field :event, as: :belongs_to
  end
end
