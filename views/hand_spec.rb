require "spec_helper"

describe Hand do
  # These UTF-8 characters will be useful for making different hands:
  # '♦', '♣', '♠', '♥'

  let(:hand) { Hand.new([Card.new("♦",10), Card.new("♥","J")]) }
  # You can add more sample hands using this same syntax, with a different variable name!

  describe "#calculate_hand" do
    # We have included some example tests below. Change these once you get started!

    it "should add the value of the cards together" do
      # Use the RSpec keyword `expect`, as it appears below, to test your assertions
      hand_total = 0
      hand.cards.each do |card|
        hand_total += card.value
      end

      expect(hand.score).to be_a(Integer)
      expect(hand.score).to eq(hand_total)
    end

    let(:good_hand) { Hand.new([Card.new("♦", 'A'), Card.new("♥","J")]) }
    let(:fine_hand) { Hand.new([Card.new("♦", 'A'), Card.new("♥",8)]) }
    let(:bad_hand) { Hand.new([Card.new("♦", 'A'), Card.new("♥",8), Card.new("♦", 8), Card.new("♥","J")]) }

    it "should evaluate an ace to be 1 or 11" do
      expect(good_hand.score).to eq(21)
      expect(fine_hand.score).to eq(19)
      expect(bad_hand.score).to eq(27)

    end

    # Add your remaining tests here.

  end
end
