module Mutations
  class UpdateUser < GraphQL::Schema::RelayClassicMutation
    graphql_name 'UpdateUser'

    field :user, Types::UserType, null: true
    field :result, Boolean, null: true

    argument :id, ID, required: true
    argument :email, String, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false

    def resolve(**args)
      user = User.find(args[:id])
      user.update(email: args[:email], first_name: args[:first_name], last_name: args[:last_name])
      {
        user: user,
        result: user.errors.blank?
      }
    end
  end
end
