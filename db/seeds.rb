# The data can be loaded with the rake db:seed
require "factory_girl"
require 'database_cleaner'
include FactoryGirl::Syntax::Methods
include NamedSeeds::DSL
FactoryGirl.find_definitions rescue false
FactoryGirl.lint
DatabaseCleaner.clean_with :truncation
DatabaseCleaner.clean

@joe = create :user, id: identify(:joe), username: "Joe"
@kash = create :user, id: identify(:kash), username: "Kash"
@abdul = create :user, id: identify(:abdul), username: "Abdul"
@emma = create :user, id: identify(:emma), username: "Emma"
@kai = create :user, id: identify(:kai), username: "Kai", admin: true
