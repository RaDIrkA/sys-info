class GetinfoController < ApplicationController
  def index
    @mem_info = %x(free -m).split("\n")[1].split(" ")[1..3]
    @sys_info = %x(uptime).split(" ")
    @cpu_info = []
    @cpu_info << @sys_info[0]
    @cpu_info << @sys_info[9].split(",")[0]
    @cpu_info << @sys_info[10].split(",")[0]
    @cpu_info << @sys_info[11]
    render 'index'
  end
end
