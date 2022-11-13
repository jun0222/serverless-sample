# 目次

<!-- TOC -->

- [目次](#目次)
- [参考記事](#参考記事)
- [環境構築](#環境構築)
  - [構築コマンド](#構築コマンド)
  - [環境変数](#環境変数)
  - [dotenv について](#dotenv-について)
- [エラー集](#エラー集)
  - [Object notation for "service" property is not supported.](#object-notation-for-service-property-is-not-supported)
    - [メッセージ](#メッセージ)
- [コマンド](#コマンド)
  - [ローカルで function 実行](#ローカルで-function-実行)
    - [説明](#説明)
    - [具体例](#具体例)
  - [関数のデプロイ](#関数のデプロイ)
    - [具体例](#具体例-1)
  - [AWS 上で function 実行](#aws-上で-function-実行)
    - [具体例](#具体例-2)
  - [定期実行の設定](#定期実行の設定)
    - [具体例](#具体例-3)
  - [関数の削除](#関数の削除)
    - [具体例](#具体例-4)

<!-- /TOC -->

# 参考記事

- [【Serverless Framework】nodejs で始めるサーバーレスチュートリアル](https://qiita.com/kousaku-maron/items/c591a1245bdd69c0dad3)
- [【Node.js】dotenv で環境変数を定義する](https://nullnull.dev/blog/dotenv-tutorial/)
- [Serverless Framework #012 – リージョン指定デプロイ](https://day-journal.com/memo/serverless-framework-012/)

# 環境構築

## 構築コマンド

```sh
. build.sh
```

↑ で以下のコマンド群が実行される

```sh
#!/bin/bash
echo '=====node====='
node # npm install -g serverlessが実行できなかったのでnode実行確認

echo '=====volta install node====='
volta install node # node動かなかったのでinstall

echo '=====npm install -g serverless====='
npm install -g serverless

echo '=====serverless create --template aws-nodejs-ecma-script --name serverless-sample --path serverless-sample====='
serverless create --template aws-nodejs-ecma-script --name serverless-sample --path serverless-sample # serverless-sampleという名前でアプリ作成

echo '=====cd serverless-sample====='
cd serverless-sample

echo '=====npm install====='
npm install

echo '=====touch README.md====='
touch README.md

echo '=====touch .env====='
touch .env

echo '=====npm i dotenv====='
npm i dotenv

echo '=====npm i axios====='
npm i axios

echo '=====touch qiita.js====='
touch qiita.js

echo '=====npm i aws-sdk====='
npm i aws-sdk
```

## 環境変数

アプリケーションからは dotenv を使う。
cli からの時は`AWS_ACCESS_KEY_ID=XXXXXXXX` `AWS_SECRET_ACCESS_KEY=XXXXXXXX`  
など直接入力する

## dotenv について

```sh
npm i dotenv
```

したので js ファイルからは.env に定義したものが取れる

`example.js`

```js
require("dotenv").config(); // .evn使いたいファイルで呼び出す。本来は1か所でまとめて呼び出す

const hello = () => {
  console.log(process.env); // 実際の.envの値があるオブジェクト
};
hello();
```

↑ みたいにして、

```sh
node example.js
```

で.env に定義した環境変数が取れる

# エラー集

## Object notation for "service" property is not supported.

### メッセージ

`Object notation for "service" property is not supported. Set "service" property directly with service name.`
が出た。  
service プロパティはオブジェクトだとダメみたいなので修正。

```yaml
service:
  name: serverless-sample
```

↓

```yaml
service: serverless-sample
```

[参考記事](https://stackoverflow.com/questions/71091145/serverless-deploy-throwing-error-object-notation-for-service-property-is-not)

# コマンド

## ローカルで function 実行

### 説明

```sh
serverless invoke local --function 関数名
```

### 具体例

```sh
serverless invoke local --function first
```

## 関数のデプロイ

### 具体例

```sh
AWS_ACCESS_KEY_ID=XXXXXXXXXX AWS_SECRET_ACCESS_KEY=XXXXXXXXXX serverless deploy -r ap-northeast-1
```

※aws config の設定をしていれば、コマンドに環境変数は入れなくて良い

## AWS 上で function 実行

### 具体例

```sh
AWS_ACCESS_KEY_ID=XXXXXXXXXX AWS_SECRET_ACCESS_KEY=XXXXXXXXXX serverless invoke --function first
```

※こちらも設定済みなら環境変数の明示は不要

## 定期実行の設定

### 具体例

`serverless.yml` を、

```yaml
functions:
  first:
    handler: first.hello
    events:
      - schedule: cron(0 * * * ? *)
```

などとして、

```sh
AWS_ACCESS_KEY_ID=XXXXXXXXXX AWS_SECRET_ACCESS_KEY=XXXXXXXXXX serverless deploy -r ap-northeast-1
```

## 関数の削除

### 具体例

```sh
AWS_ACCESS_KEY_ID=XXXXXXXXXX AWS_SECRET_ACCESS_KEY=XXXXXXXXXX serverless remove -r ap-northeast-1
```
