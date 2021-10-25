# Exercise 5 Part 1 (Exception Handling)
class ExternalServerError < StandardError
end

class MentalStateError < StandardError
end

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
    begin
      online?
    rescue
      raise ExternalServerError, "External server is offline"
    end 
  end
  def audit!
    # Could fail if external service is offline
    begin
      online?
    rescue
      raise ExternalServerError, "External server is offline, audit could fail"
    end 
  end
  def do_work
    # Amazing stuff...
  end
end

def audit_sanity(bedtime_mental_state)
  raise MentalStateError unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

if audit_sanity(bedtime_mental_state) == 0
  raise MentalStateError
else
  new_state = audit_sanity(bedtime_mental_state)
end





# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

class MentalStateError < StandardError ; end

def audit_sanity(bedtime_mental_state)
  raise MentalStateError unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work




# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

class MyCandyMachine

  def initialize
    @candy_generator.prepare = CandyMachine.new
  end

  def generate_candy
    if @candy_generator.ready?
      @candy_generator.make!
    else
      puts "sadness"
    end
  end

end
    