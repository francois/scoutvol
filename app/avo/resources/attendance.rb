class Avo::Resources::Attendance < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :event_id, as: :number
    field :slug, as: :text
    field :person_name, as: :text
    field :branch, as: :text
    field :event, as: :belongs_to
  end
end
