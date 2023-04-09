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
    # Extract the user_id parameter from the event
    user_id = event['user_id']

    # Prepare the SQL statement to retrieve all todos for the user
    sql = "SELECT id, title, completed FROM todos WHERE user_id = :user_id"

    # Bind the user_id parameter to the SQL statement
    parameters = [
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

    # Extract the rows returned by the query and format them as a list of dicts
    rows = response['records']
    todos = []
    for row in rows:
        todo = {
            'id': row[0]['longValue'],
            'title': row[1]['stringValue'],
            'completed': row[2]['booleanValue']
        }
        todos.append(todo)

    # Return the list of todos as the response
    return {
        'statusCode': 200,
        'body': json.dumps(todos)
    }
