const AWS = require("aws-sdk");

exports.handler = async () => {
    
    const documentClient = new AWS.DynamoDB.DocumentClient({ region: "us-east-1" });
    
    const params = {
        TableName: "Weather",
        Item: {
            id: "88888",
            name: "Montreal",
            day: "5153",
            date: "08252021"
        }
    };
    try{
        var data = await documentClient.put(params).promise();
        console.log(data);
    }catch(err){
        console.log(err);
    }
    return data;
};