class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      flash[:warning] = "This Job already archived"
      redirect_to root_path
    end
  end

  def index
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.lower_salary.paginate(:page => params[:page], :per_page => 5)
    when 'by_upper_bound'
      Job.published.upper_salary.paginate(:page => params[:page], :per_page => 5)
    else
      Job.published.recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)

    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])

    @job.destroy

    redirect_to jobs_path
  end

  def dps
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.where(:category => "dps").lower_salary.paginate(:page => params[:page], :per_page => 5)
            when 'by_upper_bound'
              Job.published.where(:category => "dps").upper_salary.paginate(:page => params[:page], :per_page => 5)
            else
              Job.published.where(:category => "dps").recent.paginate(:page => params[:page], :per_page => 5)
            end
  end

  def healbooner
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.where(:category => "healbooner").lower_salary.paginate(:page => params[:page], :per_page => 5)
            when 'by_upper_bound'
              Job.published.where(:category => "healbooner").upper_salary.paginate(:page => params[:page], :per_page => 5)
            else
              Job.published.where(:category => "healbooner").recent.paginate(:page => params[:page], :per_page => 5)
            end
  end

  def booner
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.where(:category => "booner").lower_salary.paginate(:page => params[:page], :per_page => 5)
            when 'by_upper_bound'
              Job.published.where(:category => "booner").upper_salary.paginate(:page => params[:page], :per_page => 5)
            else
              Job.published.where(:category => "booner").recent.paginate(:page => params[:page], :per_page => 5)
            end
  end

  def tank
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.published.where(:category => "tank").lower_salary.paginate(:page => params[:page], :per_page => 5)
            when 'by_upper_bound'
              Job.published.where(:category => "tank").upper_salary.paginate(:page => params[:page], :per_page => 5)
            else
              Job.published.where(:category => "tank").recent.paginate(:page => params[:page], :per_page => 5)
            end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden, :city, :company, :category)
  end
end
