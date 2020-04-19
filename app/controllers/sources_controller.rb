class SourcesController < ApplicationController
  def new
    @source = Source.new
  end

  def create
    @source = Source.new(source_params)
    if @source.save
      flash[:success] = 'Source created'
      redirect_to request.referer
    else
      render 'new'
    end
  end

  private

  def source_params
    params.require(:source).permit(:name, :created_at)
  end
end
