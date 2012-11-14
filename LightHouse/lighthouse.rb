class LightHouse
  
  def initialize
    @light = :OFF
  end

  def press_button
    if @light == :OFF
      @light = :ON
    else
      @light = :OFF
    end
  end
  
  def on_or_off?
    @light
  end
end