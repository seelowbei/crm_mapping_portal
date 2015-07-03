class Mapping < ActiveRecord::Base
  establish_connection( :adapter    => APP_CONFIG["adapter"],
                        :database   => APP_CONFIG["database"],
                        :username   => APP_CONFIG["username"],
                        :password   => APP_CONFIG["password"],
                        :host => APP_CONFIG["host"],
                        :port => APP_CONFIG["port"],
                        :mode => APP_CONFIG["mode"]) if defined?(APP_CONFIG)

	self.table_name = "Mapping"
  attr_accessible :parent_id, :sub_id

  def parent_id
    read_attribute("ParentID")
  end

  def sub_id
    read_attribute("SubID")
  end

  def parent_id=(value)
    write_attribute("ParentID", value.strip)
  end

  def sub_id=(value)
    write_attribute("SubID", value.strip)
  end

  def self.fuzy_search(code)
    search_code = code.strip
    Mapping.where("ParentID like ? or SubID like ?", "%#{search_code}%", "%#{search_code}%").order("ParentID ASC, SubID ASC")
  end

  def self.search(parent_code, child_code)
    p_code = parent_code.strip
    c_code = child_code.strip
    Mapping.where("ParentID like ? AND SubID like ?", p_code, c_code)
  end

  def self.record_not_exists?(parent_code, child_code)
    Mapping.search(parent_code, child_code).empty?
  end

end
