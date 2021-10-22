# EarlyBird（技術選定・実装振り返り編）

アプリ解説編は[こちら](https://github.com/kazuki0122/front)。

## アプリについて

### アプリ概要

本アプリは、寝坊防止アプリです。友達同士でグループを作り、起床時間と起きれなかった際の罰金額を決めます。  
設定した起床時間から30分の間にグループにいる全員がメッセージを送信した場合は課金は発生しませんが、一人でもメッセージを送れないと全員課金されるようになっています。  

### URL

[https://early-bird0122.netlify.app/](https://early-bird0122.netlify.app/)

### テスト用アカウント

email：test@test.com  
password：111111

## 技術選定

### 使用技術一覧

<div display='flex' align='center' justify-content='space-around'>
  <img width="120px" alt="react" src="https://user-images.githubusercontent.com/69416789/133558816-9e7cee6b-46d3-460e-90bc-da2b97edcb8c.png">&emsp; 
  <img width="80px" alt="Typescript" src="https://user-images.githubusercontent.com/69416789/133558873-3359dbc4-5ae0-4477-8a58-d7d7a07bafe7.png">&emsp;
  <img width="150px" alt="chakraUI" src="https://user-images.githubusercontent.com/69416789/133559047-33178b3f-b1eb-4f58-9e1a-78578bc36aaa.png">&emsp;
  <img width="150px" alt="rails_logo" src="https://user-images.githubusercontent.com/69416789/133559112-c0ffdb11-9b81-4c60-9e93-ba04085ab216.png">
</div>
<div display='flex' align='center' justify-content='center'>
  <img width="100px" alt="docker" src="https://user-images.githubusercontent.com/69416789/133949462-4e6da35c-6eca-4ca4-9c8c-528482cae893.png">&emsp;
  <img width="100px" alt="docker" src="https://user-images.githubusercontent.com/69416789/133559125-3e40743f-fea8-4b23-8bd3-f3349949a24d.png">&emsp;
  <img width="150px" alt="Heroku" src="https://user-images.githubusercontent.com/69416789/133559166-b9afceb8-9a95-49af-99ed-bcbf237f60bb.png">
</div>

### 技術選定の理由 ①React × TypeScript

JavaScript フレームワークを採用してる企業も多く、Vue や React などのフレームワークの使用を考えていました。  
また近年のフロントエンド開発には TypeScript は欠かせないと思い、TypeScript の学習も行いました。  
Vue.jsを使ったアプリを作成したことがある為、今回は React を使用してみたいと思い、React と TypeScript を使いよりバグの少ないコードを目指しました。

### 技術選定の理由 ②Ruby on Rails

日本語でのドキュメントが豊富であることや、基礎的な知識は学習済みである為、 Ruby on Rails を選定しました。

## 実装過程

### 苦労したところ

#### 決済機能の実装

今回の私のアプリでは stripe を使ってカード情報を事前に登録し、ユーザーと紐付けた後に罰金が発生する場合に決済をする必要がありました。  
しかし調べてみるとその場でカード情報を入力し、何かを購入するというパターンがほとんどだったので、事前にカード情報を登録し、ユーザーと紐付けをすることにかなり時間がかかってしまいました。  
また、設定時間までにユーザーがメッセージを送ったかどうかを確認しに行くために、バッチ処理を実装する必要がありました。  
そこでRails の whenever という gem を使ってバッチ処理を実装しましたが、Herokuではサポートされてないことが分かり、Heroku のアドオンにある Heoroku Schedulerを使用しています。

## 実装振り返り

DB設計やアルゴリズムなどの抽象的なものに対する理解がまだ浅いと感じました。  
とりあえず動かせるものは作れても、アプリ全体の設計を考えたときに、どれがベストなのか中々イメージできないところが多く感じました。 
また余計なレンダリングが走ったり、一部バリデーションが甘いところがまだあります。  
今後はただ動くものを作れるだけでなく、設計や最適化などを意識したアプリを作れるように努めていきたいです。

### 今後の展望

#### 今回は後回しにした機能の実装

・レスポンシブデザイン  
・Websocketを使ったリアルタイム通信  
・memo化  
