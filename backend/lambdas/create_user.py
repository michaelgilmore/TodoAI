import boto3
import json
import pymysql

def lambda_handler(event, context):
    # Get the name of the Secrets Manager secret containing the database credentials
    secret_name = event['secret_name']

    # Create a Secrets Manager client
    secrets_manager = boto3.client('secretsmanager')

    # Get the secret containing the database credentials
    secret_value = secrets_manager.get_secret_value(SecretId=secret_name)

    # Parse the secret JSON object
    secret_dict = json.loads(secret_value['SecretString'])

    # Get the database credentials from the secret
    db_host = secret_dict['host']
    db_name = secret_dict['dbname']
    db_user = secret_dict['username']
    db_password = secret_dict['password']

    # Get the user information from the event
    user = event['user']

    # Connect to the database
    conn = pymysql.connect(
        host=db_host,
        user=db_user,
        password=db_password,
        db=db_name,
        connect_timeout=5,
        cursorclass=pymysql.cursors.DictCursor
    )

    # Insert the user information into the database
    with conn.cursor() as cursor:
        sql = "INSERT INTO User (name, login) VALUES (%s, %s)"
        cursor.execute(sql, (user['name'], user['email']))
        conn.commit()

    # Close the database connection
    conn.close()

    return {
        'statusCode': 200,
        'body': 'User created successfully'
    }
