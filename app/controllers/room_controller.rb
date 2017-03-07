class RoomController < ApplicationController
	before_filter :init_items_size_list
  before_filter :authenticate_user!

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to controller: 'room', action: 'list', group: 'all'
    else
      render :action => 'new'
    end
  end

  def list
       @room = Room.new
       @issueTypes = IssueType.all


       if params[:group] == "all"
          @rooms = Room.all
       elsif params[:group] == "open"
          @rooms = Room.where("is_clean = ?", false)
       else params[:group] == "ready"
 	      @rooms = Room.where("is_clean = ?", true)
       end
 	end

  def room_params
      params.require(:room).permit(:room_nid, :description)
  end

 	def init_items_size_list
    @items_size_list ||= [Room.all.size, Room.where("is_clean = ?", false).size, Room.where("is_clean = ?", true).size]
    #                             0                           1                                       2
	end	

  def report_issue
    puts "report"
  end
    	

end
