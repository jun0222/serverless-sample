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