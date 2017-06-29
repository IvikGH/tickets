class TicketsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:create, :show]

  before_action :set_ticket, only: [:edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all
  end

  def search
    if params[:search][0] == '#'
      @tickets = Ticket.where("uniq_reference LIKE ?",
                             "%#{params[:search][1..-1]}%")
      if @tickets.size == 1
        @ticket = @tickets[0]
        render :show
      else
        render :index
      end
    else
      @tickets = Task.where("subject LIKE ? OR description LIKE ?",
                            "%#{params[:search]}%",
                            "%#{params[:search]}%")
      render :index
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.includes(:status, comments: [:user]).find(params[:id])
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.status_id = Status.find_by_title('Waiting for Staff Response').id
    AddTeferenceToTicket.add_ref(@ticket)

    respond_to do |format|
      if @ticket.save
        flash.now[:message] = 'Ticket was successfully created.'

        TicketMailer.creation_inform(@ticket).deliver_later
        @ticket = nil
      else
        flash.now[:error] = @ticket.errors.messages.to_s
      end
      format.html { render 'devise/sessions/new' }
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:employee_email, :employee, :status_id,
                                     :department_id, :subject, :description,
                                     :user_id)
    end
end
