# https://semaphoreci.com/community/tutorials/rspec-subject-helpers-hooks-and-exception-handling


# SUBJECT ------------------------------------------------------

describe Run do

  describe "attributes" do

    # PREPARE THE DATA POINT TO BE USED MULTIPLE TIMES------------------------------------------------------
    subject do
      Run.new(:duration => 32,
              :distance => 5.2,
              :timestamp => "2014-12-22 20:30")
    end

    # Don't need to explictly reference the data
    it { is_expected.to respond_to(:duration) }
    it { is_expected.to respond_to(:distance) }
    it { is_expected.to respond_to(:timestamp) }
    # ------------------------------------------------------

    end
end





# BEFORE HOOK ------------------------------------------------------


describe RunningWeek do

  describe ".count" do

    context "with 2 logged runs this week and 1 next week"

      # PREPARE THE DATA TO BE USED MULTIPLE TIMES ------------------------------------------------------
      # Exectue this code BEFORE run the tests => giving it more data
      before do
        # 2 logged runs this week
        2.times do
          Run.log(:duration => rand(10),
                 :distance => rand(8),
                 :timestamp => "2015-01-12 20:30")
        end
        # 1 logged run next week
          Run.log(:duration => rand(10),
                :distance => rand(8),
                :timestamp => "2015-01-19 20:30")
      end
      # Don't need to explictly reference the data

      context "without arguments for week" do
        it "returns 3" do
          # DO NOT need to explictly reference the data input from before
          # it will automatically input the data into Run.count as
          # before runs for EACH and every example by default ('before' = 'before(:each)')
          expect(Run.count).to eql(3)
        end
      end

      context "with: week set to this week" do
        it "returns 2" do
            # Finessing test example by selecting it for a specific week
          expect(Run.count(:week => "2015-01-12")).to eql(2)
        end
      end

  end
end





# LET HELPER ------------------------------------------------------

describe RunningWeek do

  # PREPARE THE DATA TO BE USED MULTIPLE TIMES------------------------------------------------------

  let(:monday_run) do
    Run.new(:duration => 32,
            :distance => 5.2,
            :timestamp => "2015-01-12 20:30")
  end

  let(:wednesday_run) do
    Run.new(:duration => 32,
            :distance => 5.2,
            :timestamp => "2015-01-14 19:50")
  end

  # Preparing an additional example that is a combination of the above
  let(:runs) { [monday_run, wednesday_run]}

  # Preparing data for which running week it is
  let(:running_week) { RunningWeek.new(Date.parse("2015-01-12"), runs) }

  # (!) Still need to reference the data explictly, whether for test example or test answer
  # unlike before and subject used above
  describe "#runs" do

    it "returns all runs in the week" do
      # (!) e.g. explictly reference runs run as the test example
      expect(running_week.runs).to eql(runs)
    end
  end

  describe "#first_run" do

    it "returns the first run in the week" do
      # (!) e.g. explictly reference monday run as the test answer
      # (unlike above -> only used as the test subject i.e. input)
      expect(running_week.first_run).to eql(monday_run)
    end
  end

  describe "#average_distance" do

    it "returns the average distance of all week's runs" do
      expect(running_week.average_distance).to be_within(0.1).of(5.4)
    end
  end
end



# EXCEPTIONS HANDLING ------------------------------------------------------

describe RunningWeek do

  describe "initialization" do

    context "given a date which is not a Monday" do

      it "raises a 'day not Monday' error"
        expect { RunningWeek.new(Date.parse("2015-01-13"), []) }.to raise_error("Day is not Monday")
    end
  end
end
