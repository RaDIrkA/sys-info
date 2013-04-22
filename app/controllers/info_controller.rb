class InfoController < ApplicationController
  def index
    # TODO Support Mac and Ubuntu server
    # Move this code to library
    if RUBY_PLATFORM =~ /linux/i
      @mem_info = %x(free -m).split("\n")[1].split(" ")[1..3]
      @sys_info = %x(uptime).split(",")
      @uptime = @sys_info[0]
      cpu_info = %x(cat /proc/loadavg).split(" ")[0..2]
      number_of_cores = %x(cat /proc/cpuinfo).scan(/processor/).size
      @cpu_info = []
      cpu_info.each {|i| @cpu_info << (i.to_f * 100 / number_of_cores) % 100}
      #@cpu_info << @sys_info[2].split(" ")[2].to_f * 100 / number_of_cores
      #@cpu_info << @sys_info[3].split(" ")[0].to_f * 100 / number_of_cores
      #@cpu_info << @sys_info[4].split(" ")[0].to_f * 100 / number_of_cores
      filesystems = %x(df -h).split("\n")
      @fs = []
      filesystems.each do |i|
        if i.include? "/dev/"
          @fs << i.split(" ")
        end
      end
      render 'index'
    else
      # FIX ME
      raise Exception
    end
  end

  def smeter
    render 'example.html'
  end
end