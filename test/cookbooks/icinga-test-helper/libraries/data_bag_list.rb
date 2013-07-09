class Chef::DataBag
  class << self
    def list
      Dir["#{Chef::Config[:data_bag_path]}/*"].map { |db|
        File.basename(db) }
    end
  end
end
