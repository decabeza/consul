require "csv"

namespace :db do
  desc "Imports zipcodes from the CSV file"
  task zipcodes: :environment do
    Zipcode.destroy_all

    CSV.foreach("db/zipcodes.csv", headers: true) do |line|
      code = line.to_hash["Postcode"]
      Zipcode.create!(code: code) if code.present?
    end
  end
end