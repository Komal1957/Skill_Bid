class RequestsController < ApplicationController
before_action :authenticate_user!
before_action :set_request, only: [:show, :destroy]
before_action :authorize_request, except: [:index, :show]

def index
    @requests = Request.all.order(created_at: :desc)
end

def show
    # For the "new Bid" form
    @bid = Bid.new
end

def new
    @request = Request.new
    @categories = Category.where(parent_id: nil) # Load root categories
end

def create
    @request = current_user.requests.build(request_params)
    @request.client = current_user
    @request.expires_at ||= 24.hours.from_now
    @request.status = :open

    if @request.save
        redirect_to @request, notice: "Request created successfully!"
    else
        @categories = Category.where(parent_id: nil)
        render :new, status: :unprocessable_entity
    end
end

def edit
end

def destroy
    @request.destroy
    redirect_to requests_path, notice: "Request deleted."
end

private

  def set_request
    @request = Request.find(params[:id])
  end

  def authorize_request
    authorize @request || Request
  end

  def request_params
   params.require(:request).permit(:title, :description, :budget, :expires_at, :category_id,  files: [])
  end
end
