class Api::V1::PaymentsController < ApplicationController
  # createを発火させるタイミングをどうするか？
  # Rulesテーブルからcharge額を取得する
  def create
    # if グループに所属しているuserのidとmessageのuser_idがwakeup_timeから30分以内に全てある
      # return
    # elsif 一つでも過不足があれば
      # ストライプかPay.jpかで罰金額を課金する
    # end
  end
end
