class GamesController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    if params[:search].present?
      @games = Igdb.search(params[:search][:query])
    end
  end

  def create
    @group = Group.find(params[:group_id])
    @game = Game.new(game_params)
    @game.user = current_user
    @game.group = @group
    @game.remote_background_image_url = game_params[:background_image]

    if @game.save
      redirect_to group_path(@group), notice: "Bien ajouté !"
    else
      render :new, alert: "Un problème est survenu..."
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :released, :platforms, :background_image, :description, :devs)
  end
end
