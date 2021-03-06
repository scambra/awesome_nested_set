require 'spec_helper'

describe "Helper" do
  include CollectiveIdea::Acts::NestedSet::Helper

  before(:all) do
    self.class.fixtures :categories
  end

  describe "nested_set_options" do
    def test_nested_set_options
      expected = [
        [" Top Level", 1],
        ["- Child 1", 2],
        ['- Child 2', 3],
        ['-- Child 2.1', 4],
        ['- Child 3', 5],
        [" Top Level 2", 6]
      ]
      actual = nested_set_options(Category) do |c|
        "#{'-' * c.level} #{c.name}"
      end
      actual.should == expected
    end

    def test_nested_set_options_with_mover
      expected = [
        [" Top Level", 1],
        ["- Child 1", 2],
        ['- Child 3', 5],
        [" Top Level 2", 6]
      ]
      actual = nested_set_options(Category, categories(:child_2)) do |c|
        "#{'-' * c.level} #{c.name}"
      end
      actual.should == expected
    end
  end
end
