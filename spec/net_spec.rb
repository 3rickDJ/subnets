require 'net'

describe Net do
  let(:net) { Net.new('210.10.56.0', 24, 6) }
  it 'returns the original mask address' do
    a = net.mask_address
    expect(a.to_s(2)).to eq('11111111111111111111111100000000')
  end

  it 'returns the subnet mask' do
    a = net.subnet_mask
    expect(a[:mask]).to eq('11111111111111111111111111100000')
  end

  it 'returns the magic number' do
    a = net.magic_number
    expect(a).to eq(32)
  end

  it 'returns the subnets' do
    a = net.subnets
    subnets = [
      # ['start', 'range', 'end']
      # see the pattern, and calculate the next values
      ['210.10.56.0', '1-30', '210.10.56.31'],
      ['210.10.56.32', '33-62', '210.10.56.63'],
      ['210.10.56.64', '65-94', '210.10.56.95'],
      ['210.10.56.96', '97-126', '210.10.56.127']
    ]
    expect(a[0..3]).to eq(subnets)
  end
end
