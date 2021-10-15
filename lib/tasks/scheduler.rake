desc "This task is called by the Heroku scheduler add-on"
task :test_scheduler => :environment do
  puts "scheduler test"
  puts "it works."
end

task :send_reminders => :environment do
  reservations = Reservation.where.not(status: "complete").where(patern: "no")
  reservations.each do |reservation|
    if reservation.end_time - 1.day <= Time.new
      user = User.find_by(id: reservation.user_id)
      reservation.patern = "yes"
      reservation.save
      MessageMailer.send_when_update(user, reservation).deliver
    end
  end
  puts "ended."
end