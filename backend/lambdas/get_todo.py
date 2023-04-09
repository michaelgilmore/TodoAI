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
    # Extract the todo_id parameter from the event
    todo_id = event['todo_id']

    # Prepare the SQL statement to retrieve the todo by ID
    sql = "SELECT id, title, completed FROM todos WHERE id = :todo_id"

    # Bind the todo_id parameter to the SQL statement
    parameters = [
        {'name': 'todo_id', 'value': {'longValue': todo_id}}
    ]

    # Execute the SQL statement using the RDS Data Service client
    response = rds_data.execute_statement(
        resourceArn=DB_CLUSTER_ARN,
        secretArn=DB_SECRET_ARN,
        database='todo_app_db',
        sql=sql,
        parameters=parameters
    )

    # Extract the row returned by the query and format it as a dict
    row = response['records'][0]
    todo = {
        'id': row[0]['longValue'],
        'title': row[1]['stringValue'],
        'completed': row[2]['booleanValue']
    }

    # Return the todo as the response
    return {
        'statusCode': 200,
        'body': json.dumps(todo)
    }
