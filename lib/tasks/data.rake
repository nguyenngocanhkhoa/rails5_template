namespace :data do
  desc "Generates fake data for testing"
  task sample: :environment do
    users = create_list :user, 10
  end

end
