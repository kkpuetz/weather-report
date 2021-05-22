const AWS = require('aws-sdk');

exports.handler = async () => {
  const documentClient = new AWS.DynamoDB.DocumentClient({region: 'us-east-1'});

  const params = {
    TableName: 'Weather',
    Key: {
      id: '2643743'
    }
  };

  try{
    var data = await documentClient.get(params).promise();
    console.log(data);
  }catch(err){
    console.log(err);
  }
  return data;
};