#!/bin/sh

cd /var/app
zip -r function.zip ./*

awslocal s3api create-bucket --bucket test-bucket

awslocal lambda create-function \
  --function-name test-lambda \
  --runtime python3.9 \
  --timeout 10 \
  --zip-file fileb://function.zip \
  --handler lambda_function.lambda_handler \
  --role arn:aws:iam::000000000000:role/localstack-does-not-care

awslocal lambda create-function-url-config \
  --function-name test-lambda \
  --auth-type NONE
