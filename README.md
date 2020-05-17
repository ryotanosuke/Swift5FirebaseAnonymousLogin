# Swift5FirebaseAnonymousLogin

FIreBaseを使用した、匿名掲示板アプリです。

ユーザー情報や、掲示板の呟きは、CloudサービスであるFireBaseに保存されます。

# Setup

git clone のみでシミュレーション可能です。

# Usage

匿名掲示板を使用するための、ログイン情報を登録します。

<img width="433" alt="スクリーンショット 2020-05-17 20 01 38" src="https://user-images.githubusercontent.com/64144316/82143430-ebf19200-987e-11ea-9021-79140286f6a5.png">

アイコンを選択し、名前を入力します。決定ボタン押下後、掲示板に入室可能。

<img width="435" alt="スクリーンショット 2020-05-17 20 01 54" src="https://user-images.githubusercontent.com/64144316/82143433-f0b64600-987e-11ea-912f-5e5058675f57.png">

右下のカメラボタンを押すことにより、画像と呟きの投稿が可能になります。

<img width="436" alt="スクリーンショット 2020-05-17 20 02 34" src="https://user-images.githubusercontent.com/64144316/82143515-789c5000-987f-11ea-96f8-ded2ba2765fd.png">

投稿の画像をタップすることにより、ツイッターなどにシェアが可能です。

<img width="437" alt="スクリーンショット 2020-05-17 20 02 56" src="https://user-images.githubusercontent.com/64144316/82143520-83ef7b80-987f-11ea-9d04-3b6d3a63ec4a.png">


# References

Udemy iOS講座 https://www.udemy.com/course/ios13_swift5_iphone_ios_boot_camp/

# Learn

当該アプリにより、デリゲート、テーブルビュー、クロージャー、Cloudとの連携等、非常に重要な概念を学びました。

苦労した箇所は、Cloudとの概念を把握していないとコードの記述で混乱を招きやすい点です。一つ一つのコードの役割を、理解し、どのような処理がなされているのか整理できるように、何度も復習いたしました。

今後の課題では、ユーザー情報が無記名の場合に遷移を不可にしたり、遷移中にアニメーションを付与したるするなどの、改修などが可能だと思いました。

当該プロジェクトは上記講座を参考に作成したものですが、独自の実装として、最新の投稿がアクティブになったり、デザインの変更等も行っております。
