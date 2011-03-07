require File.expand_path("../../spec_helper", File.dirname(__FILE__))

class TestJob
  def self.perform
    1.upto 5 do
      putc '+'
      sleep(1)
    end
  end
end

describe Resque::Plugins::Timeout do
  it "kills jobs that run past the time limit" do
    # set up the timeout
    Resque::Plugins::Timeout.timeout = 2

    # create a job
    Resque::Job.create('queueZ', TestJob)

    # create a worker and get the job
    worker = Resque::Worker.new('queueZ')
    job = Resque::Job.reserve('queueZ')

    # mimic the forking and running of the job (with plugin hooks)
    worker.run_hook :before_fork, job
    worker.process(job)

    worker.failed.should == 1
  end

  it 'should not timeout if the plugin is turned off' do
    # turn it off
    Resque::Plugins::Timeout.switch = :off

    # create a job
    Resque::Job.create('queueZ', TestJob)

    # create a worker and get the job
    worker = Resque::Worker.new('queueZ')
    job = Resque::Job.reserve('queueZ')

    # mimic the forking and running of the job (with plugin hooks)
    worker.run_hook :before_fork, job
    worker.process(job)

    worker.failed.should == 1
  end
end
