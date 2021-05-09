// Load the AWS SDK for Node.js
const AWS = require('aws-sdk');

exports.handler = async () => {

  // Create the DynamoDB service object
  const documentClient = new AWS.DynamoDB.DocumentClient({region: 'us-east-2'});

  const params = {
    TableName: 'Weather',
    Key: {
      id: '2643743'
    }
  };

  try{
    const data = await documentClient.get(params).promise();
    console.log(data);
  }catch(err){
    console.log(err);
  }
};