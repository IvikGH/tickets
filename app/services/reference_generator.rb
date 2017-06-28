class ReferenceGenerator

  class << self
    def generate_reference
      reference = SecureRandom.hex(9)[0, 17].upcase
      [3, 6, 10, 13].each { |i| reference[i] = '-' }
      reference
    end
  end
end
