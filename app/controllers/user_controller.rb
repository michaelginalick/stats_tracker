class UserController < ApplicationController
  skip_before_filter :verify_authenticity_token



  def index
    @user = User.new
    @current_user = User.find_by(id: session[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
      flash[:notice] = "Thanks for signing up! Please log in."
    else
      flash[:notice] = "Sign up unsuccessful."
      redirect_to root_url
    end
  end

   def show_all_teams
    @user = User.find(session[:user_id])
    @teams = Team.where(user_id: @user.id)
    respond_to do |f|
      f.html { redirect_to user_path(@user) }
      f.json { render :json => @teams }
      # f.html { render :json => @teams }
    end
  end

#'/user/:id/team/:team_id/seasons'
  def show_all_team_seasons
    @user = User.find(session[:user_id])
    @team = Team.find(params[:team_id])
    @seasons = @team.seasons

    respond_to do |f|
      f.html { redirect_to user_path(@user) }
      f.json { render :json => @seasons }
    end
  end


  #'/user/:id/season/:season_id/games'
  def show_all_season_games
    @user = User.find(session[:user_id])
    @season = Season.find(params[:season_id])
    @games = @season.games

    respond_to do |f|
      f.html { redirect_to user_path(@user) }
      f.json { render :json => @games }
    end
  end


  def show
    @user = User.find(session[:user_id])
    @teams = @user.teams #Team.where(user_id: @user.id)
    #@seasons = @teams.first.seasons #Season.where(season_id: @teams)
    @seasons = []
    @teams.each do |team|
      @seasons << team.seasons
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update #post for edit
    @user = User.find(session[:user_id])
    if @user
      @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash[:notice] = "We were unable to update your profile"
      redirect_to user_path
    end
  end

  def destroy
    @user = User.find(session[:user_id])
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
