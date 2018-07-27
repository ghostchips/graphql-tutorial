Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  
  field :allUsers, function: Resolvers::AllUsers.new
  field :allLinks, function: Resolvers::LinksSearch
end