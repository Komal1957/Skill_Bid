class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request

  def create
    @message = @request.messages.build(message_params)
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.turbo_stream
        format.html { redirect_to @request }
      else
        format.html { redirect_to @request, alert: "Could not send message." }
      end
    end
  end

  private

  def set_request
    @request = Request.find(params[:request_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
