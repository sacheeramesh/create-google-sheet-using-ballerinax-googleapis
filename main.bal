import ballerinax/googleapis.sheets;
import ballerina/io;

# [Configurable] Google sheet configuration.
#
# + refreshToken - Refresh Token  
# + clientID - Client ID  
# + clientSecret - Client Secret
type GoogleSheetConfig record {|
    string refreshToken;
    string clientID;
    string clientSecret;
|};

# Google sheet client
public configurable GoogleSheetConfig googleSheetConfigs = ?;

# Google Sheet Name
public configurable string googleSheetName = ?;

# Initialize Google sheet client
#
# + return - Google sheet Client
public isolated function initializeGoogleSheetClient() returns sheets:Client|error {

    sheets:ConnectionConfig spreadsheetConfig = {
        auth: {
            clientId: googleSheetConfigs.clientID,
            clientSecret: googleSheetConfigs.clientSecret,
            refreshUrl: sheets:REFRESH_URL,
            refreshToken: googleSheetConfigs.refreshToken
        }
    };

    final sheets:Client gsClient = check new (spreadsheetConfig);

    return gsClient;
}

public function main() returns error? {

    // Google Sheet Client
    final sheets:Client spreadsheetClient = check initializeGoogleSheetClient();

    // Google Sheet Creation Part
    sheets:Spreadsheet|error sheet = spreadsheetClient->createSpreadsheet(googleSheetName);

    io:println(sheet);

}
