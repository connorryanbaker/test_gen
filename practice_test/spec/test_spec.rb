require 'test'
describe "exponent" do
  it "correctly handles positive powers" do
    expect(exponent(5,3)).to eq(125)
  end

  it "correctly handles negative powers" do
    expect(exponent(2, -3)).to eq(1/8.0)
  end

  it "correctly handles 0" do
    expect(exponent(2, 0)).to eq(1)
  end
end

describe 'my_any' do
  a= [1,2,3]
  it "returns true if any number matches the block" do
    expect(a.my_any? { |num| num > 1 }).to eq(true)
  end

  it "returns false if no elementes match the block" do
    expect(a.my_any? { |num| num == 4 }).to eq(false)
  end
end

describe "my_merge" do
  a = {a: 1, b: 2, c: 3}
  b = {d: 4, e: 5}
  c = {c: 33, d: 4, e: 5}

  it "Merges 2 hashes and returns a hash" do
      expect(a.my_merge(b)).to eq(a.merge(b))
  end

  it "Priortizes values from the hash being merged in" do
      expect(a.my_merge(c)).to eq(a.merge(c))
  end
end

describe "#permutations" do
  it "returns all permutations of an array" do
    expect(permutations([1, 2, 3])).to match_array([[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]])
  end
end

describe 'subsets' do

  it "Correctly returns all subsets of an array" do
    expect(subsets([1, 2, 3])).to match_array([[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]])
  end

end

