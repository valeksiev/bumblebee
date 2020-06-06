Bumblebee::Configuration.configure(:school) do

  entity(:person) do |entity|
    entity.source :student
    entity.skip_unmaped_fields(false)
    entity.field :id
    entity.field :username   , key: :username  , transform: %i(reverse capitalize)
    entity.field :confirmed
    entity.field :password   , key: :password  , lambda: ->(value) { value.upcase }
    entity.field :first_name , key: :firstname , lambda: ->(value) { 'mr. ' + value}
    entity.field :name       , compound_of: [:firstname, :lastname], glued_with: ' '
    entity.field :class_id   , foreign_key: true, refers: :class, on_missing: :skip, default: nil
  end

  entity(:class) do |entity|
    entity.field :id
    entity.field :name
    entity.relation :speaker, entity_name: :person, id_field: :id, id_value: :speaker_id
  end
end
