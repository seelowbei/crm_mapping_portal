class MappingsController < ApplicationController
  before_filter :authenticate_user!
  def index
    # @mappings = Mapping.all
    @mapping = Mapping.new()
    search_code = params[:search]
    if search_code
      @mapping_list = Mapping.fuzy_search(search_code)
      if @mapping_list.present?
        respond_to do |format|
          format.html
        end
      else
        redirect_to root_path, flash: { error: "No result" }
      end
    end
  end

  def new
    @mapping = Mapping.new()
  end

  def create
    @mapping = Mapping.new(params[:mapping])
    p_code = params[:mapping][:parent_id]
    c_code = params[:mapping][:sub_id]
    if Mapping.record_not_exists?(p_code, c_code)
      respond_to do |format|
        if @mapping.save
          format.html { redirect_to root_path, notice: 'New CRM Mapping Code added successfully.' }
        else
          format.html { redirect_to root_path, flash: { error: "Some error occurs. Please contact MAS team." }}
        end
      end
    else
      redirect_to root_path, flash: { error: "Mapping code: Parent Code #{p_code}, Child Code #{c_code}already exists and cannot be added." }
    end
  end
end
