# https://semaphoreci.com/community/tutorials/rspec-subject-helpers-hooks-and-exception-handling


# SUBJECT ------------------------------------------------------

describe Run do

  describe "attributes" do

    # ------------------------------------------------------
    subject do
      Run.new(:duration => 32,
              :distance => 5.2,
              :timestamp => "2014-12-22 20:30")
    end

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

      # ------------------------------------------------------
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
      # ------------------------------------------------------

      context "without arguments for week" do
        it "returns 3" do
          expect(Run.count).to eql(3)
        end
      end

      context "with: week set to this week" do
        it "returns 2" do
          expect(Run.count(:week => "2015-01-12")).to eql(2)
        end
      end

  end
end

# LET HELPER ------------------------------------------------------

describe RunningWeek do


end
