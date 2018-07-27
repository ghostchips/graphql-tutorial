class Resolvers::AllUsers < GraphQL::Function
  
  type !types[Types::UserType]
  
  def call(_obj, _args, _ctx)
    User.all
  end
end