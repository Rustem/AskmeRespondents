MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "askme-#{Rails.env}"

#Respond.connection(Mongo::Connection.new('localhost', 27017))
#Respond.database("respond-#{Rails.env}")

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end

# Story.ensure_index(:voters);

