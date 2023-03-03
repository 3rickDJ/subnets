class Net
  def initialize(ip, mask, subnets)
    @ip = ip
    @mask = mask
    @subnets = subnets
  end

  # Returns the original mask address
  def mask_address
    ('1' * @mask).ljust(32, '0').to_i(2)
  end

  def subnet_mask
    borrow_bits = Math.log2(@subnets + 2).ceil
    mask = ('1' * (@mask + borrow_bits)).ljust(32, '0')
    { mask:, borrow_bits:, offset: borrow_bits + @mask }
  end

  def magic_number
    stats  = subnet_mask
    mask   = stats[:mask]
    offset = stats[:offset]
    # find the affected octet
    case offset / 8
    when 4
      raise 'Invalid mask'
    when 3
      # extract the nth octet from mask
      256 - mask[24..31].to_i(2)
    when 2
      256 - mask[16..23].to_i(2)
    when 1
      256 - mask[8..15].to_i(2)
    when 0
      256 - mask[0..7].to_i(2)
    end
  end

  def subnets
    increment = magic_number
    stop = 2**subnet_mask[:borrow_bits] - 1
    a = (0..stop).map do |i|
      i * increment
    end
    b = (1..(stop+1)).map do |i|
      i * increment - 1
    end
    c = a.zip(b).map { |a,b| "#{a+1}-#{b-1}" }
    a.zip(c, b)
  end
end
