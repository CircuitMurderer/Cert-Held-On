#!/usr/bin/ruby

require 'optparse'
require 'open3'

def exec(path)
  output, error, status = Open3.capture3 path
  raise error if !status.success?
  print output
  sleep 1
  output
end

class Controller
  def initialize
    @base = 'scripts/'
    @paths = {
      :register => @base + 'registerUser.sh',
      :enroll => @base + 'enrollUser.sh',
      :start => @base + 'peerStartUp.sh',
      :inst => @base + 'instCC.sh',
      :test => @base + 'testCC.sh',
      :net => @base + 'network.sh'
    }

    @export_base = 'export CHAINCODE_ID='
    @cc_id_path = 'scripts/chaincodeID.sh'
  end

  def start_network
    output = exec @paths[:net] + ' -u'
  end

  def stop_network
    output = exec @paths[:net] + ' -d'
  end

  def register_user
    output = exec @paths[:register]
  end

  def enroll_user
    output = exec @paths[:enroll]
  end
  
  def start_peer
    output = exec @paths[:start]
  end

  def install_cc
    output = exec @paths[:inst]
    out_s = output.split '\n'

    cc_id = get_cc_id out_s.last
    print 'CC ID:' + cc_id

    write_cc_id @export_base + cc_id
  end

  def test_cc
    output = exec @paths[:test]
    print output
  end

  def get_cc_id(text)
    regex = /basic_1:[a-zA-Z0-9]+/
    match = text.match regex
    match.to_s
  end

  def write_cc_id(cc_id_s)
    File.open @cc_id_path, 'w' do |file| 
      file.puts cc_id_s
    end
  end

  def system_up
    start_network
    register_user
    enroll_user
    start_peer
    install_cc
    test_cc
  end

  def system_down
    stop_network
  end

  def run_by_opt(opt)
    system_down if opt[:down]
    system_up if opt[:up]
  end
end

options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = "Cert-Held-On: A simple cert manager via blockchain.\n"
  opt.banner += "Please ensure that you have installed the environments.\n"

  opt.separator 'If you haven\'t install the environments, please check README.md.'
  opt.separator 'Parameters:'

  opt.on '-u', '--up', 'Start up the network.' do
    options[:up] = true
    options[:down] = false
  end

  opt.on '-d', '--down', 'Shut down the network.' do
    options[:up] = false
    options[:down] = true
  end

  opt.on '-r', '--restart', 'Restart the network.' do
    options[:up] = true
    options[:down] = true
  end

  opt.on_tail '-h', '--help', 'Show help message.' do
    puts opt
    exit
  end
end

opt_parser.parse!(ARGV)
c = Controller.new
c.run_by_opt options
