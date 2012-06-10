require 'puppet/reports'

Puppet::Reports.register_report(:reportlog) do
  desc "Send all received logs to the local log destinations.  Usually
    the log destination is syslog."

  def process
    self.logs.each do |log|
      log.source = "//#{self.host}/#{log.source} [reportlog]"
      Puppet::Util::Log.newmessage(log)
    end
    self.metrics.each do |metric,data|
      Puppet.info("[reportlog] metric=#{metric}")
    end
  end
end

