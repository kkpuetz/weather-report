// Load the AWS SDK for Node.js
const AWS = require('aws-sdk');

// Create the DynamoDB service object
const ddb = new AWS.DynamoDB.DocumentClient({region: 'us-east-2'});

//handler
exports.handler = async (event, context, callback) => {
    const requestId = context.awsRequestId;
    await putMessage(requestId).then(() => {
        callback(null, {
            statusCode: 201,
            body: '',
            headers: {
                'Access-Control-Allow-Origin': '*',
            },
        });
    }).catch((err) => {
        console.error(err);
    });
};

function putMessage(requestId) {
  const params = {
    TableName: 'Weather',
    Item:{
        'id' : '35',
        'name' : 'Chicago',
        'day' : '2119.76',
        'dt' : '18885'
    }
    }
    return ddb.put(params).promise();
  };
 

