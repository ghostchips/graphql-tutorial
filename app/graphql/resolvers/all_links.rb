class Resolvers::AllLinks < GraphQL::Function
  
  type !types[Types::LinkType]
  
  def call(_obj, _args, _ctx)
    Link.all
  end
end