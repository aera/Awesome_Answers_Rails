class TipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @answer = Answer.find params[:answer_id]
    @tip = Tip.new
  end

  def create
    @answer = Answer.find params[:answer_id]
    @tip = @answer.tips.new tip_params
    if @tip.save
      # redirect to payments page
      render plain: 'should redirect to payments page'
    else
      render :new
    end
  end

  private

  def tip_params
    params.require(:tip).permit(:amount)
  end
end
