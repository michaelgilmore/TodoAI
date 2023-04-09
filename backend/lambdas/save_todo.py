import json
import os
import boto3
import pymysql

# Initialize the RDS Data Service client
rds_data = boto3.client('rds-data')

# Get the Aurora cluster ARN and database credentials from environment variables
DB_CLUSTER_ARN = os.environ['DB_CLUSTER_ARN']
DB_SECRET_ARN = os.environ['DB_SECRET_ARN']

# Lambda function handler
def lambda_handler(event, context):
    # Extract the todo data from the event
    title = event['title']
    completed = event['completed']
    user_id = event['user_id']

    # Prepare the SQL statement to insert the new todo
    sql = "INSERT INTO todos (title, completed, user_id) VALUES (:title, :completed, :user_id)"

    # Bind the todo data to the SQL statement
    parameters = [
        {'name': 'title', 'value': {'stringValue': title}},
        {'name': 'completed', 'value': {'booleanValue': completed}},
        {'name': 'user_id', 'value': {'longValue': user_id}}
    ]

    # Execute the SQL statement using the RDS Data Service client
    response = rds_data.execute_statement(
        resourceArn=DB_CLUSTER_ARN,
        secretArn=DB_SECRET_ARN,
        database='todo_app_db',
        sql=sql,
        parameters=parameters
    )

    # Return a success message as the response
    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Todo saved successfully'})
    }
