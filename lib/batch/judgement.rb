require "./app/models/Rule"
require "./app/models/Group"
require "./app/models/Result"
require "./app/models/Payment"

class Batch::Judgement < ApplicationRecord
  def self.hoge
    puts "Hoge!"
  end

  def self.judgement 
    puts DateTime.now
    return unless Rule.where(checked: 0).present? 
    unchecked_rules = Rule.where(checked: 0)
    p "まだチェックされてないルール#{unchecked_rules}"
    unchecked_rules.each do |rule|
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

      # 処理を実行
      if group.users.ids == create_message_users_id
        puts "誰も課金されませんでした"
        payment = Payment.new(amount:0,payed: false)
        p payment.save!
        p rule.checked
        p payment.id
        create_message_users_id.each do |user_id|
        p "ユーザーのid#{user_id}"
        p result = Result.new(result: true, rule_id: rule.id, user_id: user_id, payment_id: payment.id)
        p result.save!
        # チェック済みに変更
        rule.update(checked: true)
        end
      else
        puts '全員課金です'
      end
    end
  end
end