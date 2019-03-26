module Types
  class QueryType < Types::BaseObject

    field :users, [Types::UserType], null: false
    def users
      User.all
    end

    field :user, Types::UserType, null: true do
      description "Find a user by ID"
      argument :id, ID, required: true
    end
    def user(id:)
      User.find(id)
    end

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
