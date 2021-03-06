class CandidatesController < ApplicationController

  before_action :find_candidate, except: [:new, :create, :index]
                                 #only:[:show, :edit, :update, :destroy, :vote]

  def index
    @candidates = Candidate.all
    # @candidates = Candidate.young_people
    # @candidates = Candidate.where("age < 40")
  end

  def show 
  end

  def new
    @candidate = Candidate.new
  end

  def create

    @candidate = Candidate.new(candidate_params)

    if @candidate.save
    redirect_to "/candidates" , notice: "Candidate created!" # OK
    else
      render :new# new.html.erb
    end
  end

  def edit 
  end

  def update  

    if @candidate.update(candidate_params)
      redirect_to "/candidates" , notice: "Candidate updated!"
    else
      render :edit
    end
  end

  def destroy 
    @candidate.destroy
    redirect_to "/candidates" , notice: "Candidate deleted !!!!!"
  end
  
  def vote 
    # VoteLog.create(candidate: @candidate, ip_address: request.remote_ip) 
    @candidate.vote_logs.create(ip_address: request.remote_ip)

    #send mail
    # VoteMailer.vote_notify('gian910147@gmail.com').deliver
    VoteMailJob.perform_later

    redirect_to "/candidates", notice: "Voted !!!!!"
  end


  private
  def candidate_params
    params.require(:candidate).permit(:name, :party, :age, :politics)
  end

  def find_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end
end
