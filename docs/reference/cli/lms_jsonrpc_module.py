import requests
def lms_jsonrpc(lms:tuple,
                cmdlist:list,
                id:str = None,
                player:str = None,
                full_response:bool = None) -> dict:
    """
    This uses the requests function to send json to LMS's JSON/RPC CLI interface.
    
    The function has five named parameters, of which two are Required.
    
    Parameter: lms (Required)
        Parameter value must be a tuple like ("192.168.1.21", "9000") giving the IPV4 address
        of the LMS server, and the port number of the web interface (usually 9000)
    
    Parameter: cmdlist (Required)
        This is the CLI command.
        Note that the parameter cmdlist must be a list
        Example: cmdlist=["name", "New Name for Player"]
        Example: cmdlist=["players", 0, 4]
    
    Parameter: player (Optional)
        This parameter is needed when the CLI command syntax expects the 
        player ID as the first parameter, such as the 'name' command for players.
        Value for the parameter is player MAC address.
        Example: player='aa:bb:cc:dd:ee:ff'

    Parameter: id (Optional)
        Parameter is optional.
        Included for completeness. 
        Not clear what its purpose is. 
    
    Parameter: full_response (Optional)
        This parameter determines which part(s) of the JSON object from the server
        are returned by this function. 
        The default (full_response parameter omitted or set to False) is to return the "result" part only.
        If you include full_response=True, then all parts are returned.
    
    Response from Server    
        The full JSON object from the server contains four items, 
          "params" - input parameters, always present, essentially same as what was submitted
                   via the 'cmdlist' and 'player' parameters
          "method" - always the value "slim.request", 
          "result" - returned values from the command. always present but can be null.
          "id" - this will be null unless a value for id included as input
    """
    # These code blocks handle default values while avoiding Mutable Default Arguments
    if id == None:
        id = ''
    if player == None:
        player = "-"
    if full_response == None:
        full_response = False

    data = {'id': id, 'method': 'slim.request', 'params': [player, cmdlist]}
    LMS_JSONRPC_URL = f'http://{lms[0]}:{lms[1]}/jsonrpc.js'
    r = requests.get(LMS_JSONRPC_URL, json=data).json()
    if full_response:
        returned_json = r
    else:
        returned_json = r['result']
    return returned_json