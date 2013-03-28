class GetinfoController < ApplicationController
  def index
    @mem_info = %x(free -m).split("\n")[1].split(" ")[1..3]
    @sys_info = %x(uptime).split(" ")
    @cpu_info = []
    @uptime = @sys_info[0]
    if @uptime.include? "day"
      @cpu_info << @sys_info[9].split(",")[0]
      @cpu_info << @sys_info[10].split(",")[0]
      @cpu_info << @sys_info[11]
    else
      @cpu_info << @sys_info[7].split(",")[0]
      @cpu_info << @sys_info[8].split(",")[0]
      @cpu_info << @sys_info[9]
    end
    render 'index'
  end
end
