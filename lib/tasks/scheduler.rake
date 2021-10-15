desc "This task is called by the Heroku scheduler add-on"
task :test_scheduler => :environment do
  puts "scheduler test"
  puts "it works."
end

task :judge_scheduler => :environment do
  puts DateTime.now
  exit unless Rule.where(checked: 0).filter{|rule| rule.wakeup_time.to_date == DateTime.now.to_date }.present?

  today_unchecked_rules = Rule.where(checked: 0).filter{|rule| rule.wakeup_time.to_date == DateTime.now.to_date }
  p "まだチェックされてないルール#{today_unchecked_rules}"

  today_unchecked_rules.each do |rule|
    # グループのレコードを取得
    group = Group.find(rule.group_id)
    # 時間内に送ったメッセージ全て
    safe_messages = group.messages.filter do |message|  
      rule.wakeup_time >= message.created_at && rule.wakeup_time - 1800 <= message.created_at
    end

    p "時間内に送ってきたメッセージ#{safe_messages}"

    # 時間内に送ったメッセージのuser_id
    create_message_users_id = safe_messages.map{|message| message.user_id}.uniq.sort

    p "時間内にメッセージを送ったユーザーのid#{create_message_users_id}"

    # グループに参加してるユーザーのidsを取得
    participating_user_ids = group.group_users.where(status: 'accepted').map{|user| user.user_id}.sort
    
    # グループに参加してるユーザーのレコード 
    participating_user = rule.group.group_users.where(status: 'accepted').map{|user| user.user}.sort

    # 処理を実行
    if participating_user_ids == create_message_users_id
      puts "誰も課金されませんでした"
      payment = Payment.new(amount: 0)
      p payment.save!
      p rule.checked
      p payment.id
      create_message_users_id.each do |user_id|
        p "ユーザーのid#{user_id}"
        p result = Result.new(result: true, rule_id: rule.id, user_id: user_id, payment_id: payment.id)
        p result.save!
        # チェック済みに変更
      end
      rule.update(checked: true)
    else
      puts '全員課金です'
      # 課金額
      p payment = Payment.new(amount: rule.charge)
      p payment.save!
      participating_user_ids.each do |user_id|
        p "ユーザーのid#{user_id}"
        if create_message_users_id.include?(user_id)
          p safe_user = Result.new(result: true, rule_id: rule.id, user_id: user_id, payment_id: payment.id)
          p safe_user.save!
        else
          p out_user = Result.new(result: false, rule_id: rule.id, user_id: user_id, payment_id: payment.id)
          p out_user.save!
        end
      end
      begin
        participating_user.each do |user|
          intent = Stripe::PaymentIntent.create({
            amount: rule.charge,
            currency: 'jpy',
            customer: user.card.customer_id,
            payment_method: user.card.payment_method_id,
            off_session: true,
            confirm: true,
            })
          end
          p rule.update(checked: true)
      rescue Stripe::CardError => e
        # Error code will be authentication_required if authentication is needed
        puts "Error is: \#{e.error.code}"
        payment_intent_id = e.error.payment_intent.id
        payment_intent = Stripe::PaymentIntent.retrieve(payment_intent_id)
        puts payment_intent.id
      end
    end
  end
end