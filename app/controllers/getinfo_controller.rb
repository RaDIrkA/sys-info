class GetinfoController < ApplicationController
  def index
    @mem_info = %x(free -m).split("\n")[1].split(" ")[1..3]
    @sys_info = %x(uptime).split(",")
    @cpu_info = []
    number_of_cores = %x(cat /proc/cpuinfo).scan(/processor/).size
    @uptime = @sys_info[0]
    @cpu_info << @sys_info[2].split(" ")[2].to_f * 100 / number_of_cores
    @cpu_info << @sys_info[3].split(" ")[0].to_f * 100 / number_of_cores
    @cpu_info << @sys_info[4].split(" ")[0].to_f * 100 / number_of_cores
    filesystems = %x(df -h).split("\n")
    @fs = []
    filesystems.each do |i|
      if i.include? "/dev/"
        @fs << i.split(" ")
      end
    end
    render 'index'
  end
end
