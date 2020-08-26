# frozen_string_literal: true

module Mina
  module Helpers
    module Output
      def print_line(line)
        case line
        when /^-+> (.*?)$/
          print_status Regexp.last_match[1]
        when /^! (.*?)$/
          print_error Regexp.last_match[1]
        when /^\$ (.*?)$/
          print_command Regexp.last_match[1]
        else
          print_stdout line
        end
      end

      def print_status(msg)
        puts "#{Configuration.instance.fetch(:output_prefix)}#{color('----->', 32)} #{msg}"
      end

      def print_error(msg)
        puts "#{Configuration.instance.fetch(:output_prefix)} #{color('!', 33)}     #{color(msg, 31)}"
      end

      def print_stderr(msg)
        if msg =~ /I, \[/ # fix for asset precompile
          print_stdout msg
        else
          puts "#{Configuration.instance.fetch(:output_prefix)}       #{color(msg, 31)}"
        end
      end

      def print_command(msg)
        puts "#{Configuration.instance.fetch(:output_prefix)}       #{color('$', 36)} #{color(msg, 36)}"
      end

      def print_info(msg)
        puts "#{Configuration.instance.fetch(:output_prefix)}       #{color(msg, 96)}"
      end

      def print_stdout(msg)
        puts "#{Configuration.instance.fetch(:output_prefix)}       #{msg}"
      end

      def color(str, color)
        ENV['NO_COLOR'] ? str : "\033[#{color}m#{str}\033[0m"
      end
    end
  end
end
