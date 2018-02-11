class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin
  before_action :set_category, :only =>[:index, :create, :update, :destroy]
  def index
  	@categories = Category.all
  	@category = Category.new
  end
  def create
	  @category = Category.new(category_params)
	  if @category.save
	    flash[:notice] = "category was successfully created"
	    redirect_to admin_categories_path

	  else
	    @categories = Category.all
	    render :index
	  end
	end
	def update
		
		if @category.update(category_params)
			redirect_to admin_categories_path
			flash[:notice] = "category is successfully created"
		else
			@category.all
			render :index
		end
	end
	def destroy
		
		@category.destroy
		flash[:alert] = "category was successfully deleted"
		redirect_to admin_categories_path
	end
	private

	def category_params
	  params.require(:category).permit(:name)
	end

	def set_category
	 if params[:id]
      @category = Category.find(params[:id])
    end
	end
end
