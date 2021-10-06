class Api::V1::RulesController < ApplicationController
  # グループページに課金額や起きる時間を表示するために必要
  def index
    group = Group.find(params[:id])
    rules = group.rules.find_by(checked: false)
    wakeup_time = rules.wakeup_time.strftime("%m月%d日%H時%M分")
    amount = rules.charge
    render json: { status: 'success', data: rules, wakeup_time: wakeup_time, amount: amount}
  end

  def create
    rule = Rule.new(rules_params)
    if rule.save
      wakeup_time = rule.wakeup_time.strftime("%m月%d日%H時%M分")
      amount = rule.charge
      render json: { status: 'success', data: rule, wakeup_time: wakeup_time, amount: amount}
    else
      render json: { status: 'error', error: rule.errors.messages }
    end
  end

  def rules_params
    params.require(:rule).permit(:charge, :wakeup_time, :group_id)
  end
end
