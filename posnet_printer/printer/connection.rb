require "rxtx/rxtxcomm"

import gnu.io.CommPort
import gnu.io.CommPortIdentifier
import gnu.io.SerialPort

module Posnet
  class Printer
    class Connection
      include SerialPortHelper
      DRV_NAME = "Posnet Printer Ruby Driver"
      PROCESSING_NAP = 0.5
    
      #logger
      
      def initialize(port_name)
        if serial_port_names.include? port_name
          @port_id = CommPortIdentifier.getPortIdentifier(port_name)
          @port = @port_id.open DRV_NAME, (PROCESSING_NAP * 1000).to_i
          @streams = {:out => @port.getOutputStream(), :in => @port.getInputStream()}
        end
      end
    
      def send(string)
        open do |stream|
          stream[:out].write string.to_java_string.bytes
        end
      end
    
    
      def open(&block)
        if block_given?
          result = yield @streams
          return result
        else
          return @port
        end
      end

      def close
        @streams.values.each(&:close)
        @port.close if @port.is_a? SerialPort
      end
    end
  end
end