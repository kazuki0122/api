class Api::V1::ResultsController < ApplicationController
  def index
    group = Group.find(params[:id])
    if group.rules.last.results.empty? 
      data_exist = false 
      return render json: { status: 'success', data_exist: data_exist}
    end

    last_results = group.rules.last.results
    data_exist = true
    if last_results.map{|result| result.result}.all?
      boolean = true
      # ユーザーのレコード
      user_data = last_results.map{|result| result.user}
    else
      # 起きれなかった時
      boolean = false
      false_result = last_results.where(result: false)
      # メッセージを送信しなかったユーザーのレコードを取得
      user_data = false_result.map{|result| result.user}
    end
    render json: { status: 'success',boolean: boolean, user_data: user_data, data_exist: data_exist}
  end
end
