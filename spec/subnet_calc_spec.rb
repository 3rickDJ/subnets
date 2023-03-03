require 'subnet_calc'

describe SubnetCalc do
  context 'when given a valid IP address and mask' do
    test 'return the net address' do
      subnet = SubnetCalc.new('192.168.1.9', 24)
      expect(subnet.net_address).to eq('192.168.1.0')
      subnet = SubnetCalc.new('192.168.7.9', 16)
      expect(subnet.net_address).to eq('192.168.0.0')
      subnet = SubnetCalc.new('192.168.1.9', 30)
      expect(subnet.net_address).to eq('192.168.1.8')
    end

    test 'return the broadcast address' do
      subnet = SubnetCalc.new('192.168.1.9', 30)
      expect(subnet.broad_address).to eq('192.168.1.11')
    end

    test 'return the net mask' do
      subnet = SubnetCalc.new('192.168.1.9', 28)
      expect(subnet.net_mask).to eq('255.255.255.240')
      subnet = SubnetCalc.new('192.168.1.9', 32)
      expect(subnet.net_mask).to eq('255.255.255.252')
    end

    test 'return the magic number, octet, incriment' do
      subnet = SubnetCalc.new('192.190.0.0', 24)
      expect(subnet.magic_attrs(4)).to eq({ magic: 3, octet: 4, incr: 64 })
      subnet = SubnetCalc.new('192.168.1.0', 28)
      expect(subnet.magic_attrs(2)).to eq({ magic: 2, octet: 4, incr: 8 })
    end

    test 'return the new subnet mask' do
      subnet = SubnetCalc.new('192.190.0.0', 24)
      expect(subnet.sub_mask(4)).to eq('255.255.255.192')
      subnet = SubnetCalc.new('192.168.1.9', 30)
      expect(subnet.sub_mask(3)).to eq('255.255.255.252')
    end
  end
end
