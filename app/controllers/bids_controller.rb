class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request
  before_action :authorize_bid

  def create
    @request = Request.find(params[:request_id])
    @bid = @request.bids.build(bid_params)
    @bid.user = current_user

    respond_to do |format|
        if @bid.save
            # Email the Client 
            RequestMailer.with(request: @request, bid: @bid).new_bid.deliver_now

            #Check if anyone wasoutbid
            previous_lowest = @request.bids.where.not(id: @bid.id).order(amount: :asc).first

            if previous_lowest && @bid.amount < previous_lowest.amount
                RequestMailer.with(request: @request, current_bid: previous_lowest).outbid.deliver_now
            end
                
            #1. Success: Send the turbo stream update
            format.turbo_stream
            #2. Fallback: For users without JS enabled
            format.html { redirect_to @request, notice: "Bid placed!" }
        else
            # Error: SStay on the page and show alert
            format.html { redirect_to @request, alert: @bid.errors.full_messages.to_sentence }
        end
    end
  end    

  def destroy
    @bid = @request.bids.find(params[:id])
    if @bid.destroy
      redirect_to @request, notice: "Bid retracted."
    else
      redirect_to @request, alert: "Could not retract bid."
    end
  end

  private

  def set_request
    @request = Request.find(params[:request_id])
  end

  def authorize_bid
    authorize Bid
  end

  def bid_params
    params.require(:bid).permit(:amount, :message)
  end
end