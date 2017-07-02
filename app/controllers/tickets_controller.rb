class TicketsController < ApplicationController

  skip_before_action :authenticate_user!, only: %I[create show]

  before_action :set_ticket, only: %I[edit update destroy]

  respond_to :html

  # GET /tickets
  def index
    @tickets = Ticket.all
  end

  def search
    if search_by_uniq_reference?
      @tickets = Ticket.where("uniq_reference LIKE ?",
                             "%#{params[:search][1..-1]}%")
      if @tickets.size == 1
        @ticket = @tickets[0]
        @actions = ActionsGatherer.call(params[:id])
        render :show
      else
        render :index
      end
    else
      @tickets = Ticket.where("subject LIKE ? OR description LIKE ?",
                              "%#{params[:search]}%",
                              "%#{params[:search]}%")
      render :index
    end
  end

  # GET /tickets/1
  def show
    @ticket = Ticket.find(params[:id])
    @actions = ActionsGatherer.call(params[:id])
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit; end

  # POST /tickets
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.status_id = Status.find_by_title('Waiting for Staff Response').id
    AddTeferenceToTicket.add_ref(@ticket)

    if @ticket.save
      flash.now[:message] = 'Ticket was successfully created.'

      TicketsMailer.creation_inform(@ticket).deliver_later
      @ticket = nil
    else
      flash.now[:error] = @ticket.errors.messages.to_s
    end
    render 'devise/sessions/new'
  end

  # PATCH/PUT /tickets/1
  def update
    if @ticket.update(ticket_params)
      TicketChangesWriter.write_changes(@ticket)
      redirect_to @ticket, notice: 'Ticket was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tickets/1
  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'
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

  def search_by_uniq_reference?
    params[:search][0] == '#'
  end
end
