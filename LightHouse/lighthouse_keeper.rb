require 'lighthouse.rb'

class LightHouseKeeper
  attr_reader :days_on_duty, :status
  def initialize
    @lighthouse = LightHouse.new
    @status = :AWAKE
    @days_on_duty = 0
  end

  def restart_duty
    @days_on_duty = 0
  end

  def is_Dawn
    wake_up
    @days_on_duty += 1
    @lighthouse.press_button
  end

  def is_Dusk
    @lighthouse.press_button
    go_to_bed
  end

  private
  def wake_up
    @status = :AWAKE
  end
  
  def go_to_bed
    @status = :ASLEEP
  end
end