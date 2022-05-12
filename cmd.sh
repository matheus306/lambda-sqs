aws --endpoint-url=http://localhost:4566 iam create-role \
    --role-name trigger \
    --assume-role-policy-document '{"Version": "2012-10-17", "Statement": [{"Effect": "Allow", "Action": ["lambda:InvokeFunction"]}, {"Effect": "Allow", "Action": ["sqs:SendMessage", "sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"]}]}'


aws --endpoint-url=http://localhost:4566 \
lambda create-function --function-name lambda \
--zip-file fileb://lambda.zip \
--handler lambda/main.handler --runtime python3.8 \
--role arn:aws:iam::000000000000:role/trigger


aws --endpoint-url=http://localhost:4566 lambda invoke --function-name lambda response.json


aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name cruzeiro


aws --endpoint-url=http://localhost:4566 lambda create-event-source-mapping \
    --batch-size 1 \
    --event-source-arn arn:aws:sqs:us-east-1:000000000000:cruzeiro \
    --function-name arn:aws:lambda:us-east-1:000000000000:function:lambda
