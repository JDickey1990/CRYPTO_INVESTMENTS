require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# in order to send patch and delete requests I will need to ass this line of code here...
use Rack::MethodOverride

#mount other controllers with 'use'
run ApplicationController
use CoiNsController
use UseRsController

