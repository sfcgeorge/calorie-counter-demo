# The data can be loaded with the rake db:seed
require "factory_girl"
include FactoryGirl::Syntax::Methods
include NamedSeeds::DSL
FactoryGirl.find_definitions rescue false
FactoryGirl.lint

@joe = create :user, id: identify(:joe), username: "Joe"
@kash = create :user, id: identify(:kash), username: "Kash"
@abdul = create :user, id: identify(:abdul), username: "Abdul"
@emma = create :user, id: identify(:emma), username: "Emma"
@ben = create :user, id: identify(:ben), username: "Ben"
