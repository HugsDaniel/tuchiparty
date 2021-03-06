class GroupsController < ApplicationController
  def show
    @group    = Group.find(params[:id])
    @books    = @group.books.includes(:comments, :user)
    @movies   = @group.movies.includes(:user)
    @series   = @group.series.includes(:user)
    @games    = @group.games.includes(:user)
    @comment  = Comment.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      current_user.add_to(@group)
      redirect_to group_path(@group), notice: "Bien créé !"
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :image)
  end
end
