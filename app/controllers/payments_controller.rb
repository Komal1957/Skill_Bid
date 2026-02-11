class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request

  def create
    # 1. Create the Transaction Record in our DB (Pending)
    @transaction = EscrowTransaction.create!(
      user: current_user,
      request: @request,
      amount: @request.budget, # Funding the full budget
      status: :pending
    )

    # 2. Create Stripe Checkout Session
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: {
            name: "Escrow for: #{@request.title}",
          },
          unit_amount: (@request.budget * 100).to_i, # Stripe uses cents
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: request_url(@request) + "?payment=success",
      cancel_url: request_url(@request) + "?payment=cancelled",
    )

    render json: { id: session.id }
  end

  def success
    # This action is hit when Stripe redirects back
    # In a real app, you'd use Webhooks to verify securely.
    # For this tutorial, we trust the URL param.
    
    @transaction = current_user.transactions.where(request: @request).last
    if @transaction
      @transaction.update(status: :completed)
      flash[:notice] = "Payment successful! Funds held in escrow."
    else
      flash[:alert] = "Payment record not found."
    end
    redirect_to @request
  end

  def release_funds
    @request = Request.find(params[:request_id])
    @transaction = @request.escrow_transactions.find(params[:id])
  
    if @transaction.update(status: :released)
      redirect_to @request, notice: "Funds have been released to the freelancer."
    else
      redirect_to @request, alert: "Could not release funds."
    end
  end



  private

  def set_request
    @request = Request.find(params[:request_id])
  end
end