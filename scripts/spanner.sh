#!/bin/bash

PROJECT_ID="YOUR_PROJECT_ID"
INSTANCE_NAME="cymbal-spanner-instance"
DATABASE_NAME="transactions"

gcloud config set project $PROJECT_ID
gcloud config set spanner/instance $INSTANCE_NAME 
gcloud spanner databases create $DATABASE_NAME

gcloud spanner databases ddl update $DATABASE_NAME \
  --ddl='CREATE TABLE Transactions ( TransactionId INT64 NOT NULL, Timestamp INT64 NOT NULL, Sale INT64 NOT NULL) PRIMARY KEY (TransactionId)' 

gcloud spanner rows insert --database=$DATABASE_NAME\
      --table=Transactions \
      --data=TransactionId=1,Timestamp=1577836800,Sale=52 

# add 100 rows of data with random timestamps, transaction ids, and sales 
for i in {2..100}
do
  gcloud spanner rows insert --database=$DATABASE_NAME\
      --table=Transactions \
      --data=TransactionId=$i,Timestamp=$RANDOM,Sale=$RANDOM 
done