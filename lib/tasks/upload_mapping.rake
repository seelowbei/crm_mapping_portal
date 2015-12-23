require 'csv'
namespace :db do
  namespace :crm do
    desc "active users data"
    task :add_mapping => :environment do
     CRM_DB = TinyTds::Client.new(:adapter  => APP_CONFIG["adapter"],
                                  :username => APP_CONFIG["username"],
                                  :password => APP_CONFIG["password"],
                                  :host => APP_CONFIG["host"],
                                  :port => APP_CONFIG["port"],
                                  :mode => APP_CONFIG["mode"],
                                  :database => APP_CONFIG["database"])

     csv_text = File.read(Rails.root.join("lib", "crm_mapping_20150514.csv"))
     csv_rows = CSV.parse(csv_text, :row_sep => :auto, :col_sep => ",", :headers => true)
     csv_rows.each do |row|
        puts row
        query =  CRM_DB.execute("INSERT INTO MAPPING (ParentID, SubID) VALUES ('#{row["ParentID"]}', '#{row["SubID"]}')")
        query.insert
     end
    end
  end
end

##to run: RAILS_ENV=production rake db:crm:add_mapping
