# Using Python for LMS CLI

This page provides some basic Python code to enable interaction with LMS via the cli using the JSON/RPC mechanism.
There is a small module you can download and use to run JSON RPC commands. On this page there are some examples of Python code using this module.


## Getting started

There is a Python module, filename: **lms_jsonrpc_module.py** available to download which contains a single function **lms_jsonrpc()**.

To start:

* Take this link to download file [lms_jsonrpc_module.py](lms_jsonrpc_module.py) to your Python working directory.
* Create and run a script like this to verify it is working.

```
from lms_jsonrpc_module import lms_jsonrpc
myLMS = ('192.168.1.12','9000') # put in values there for your LMS server
print(lms_jsonrpc(lms=myLMS, cmdlist = ['serverstatus']))
```

* Expect response like this

```
{'lastscan': '1721095236', 'version': '9.0.0', 'uuid': '9caf975e-f502-47db-ad3e-135ab16a86fa',
'ip': '192.168.1.12', 'httpport': '9000', 'info total albums': 592, 'info total artists': 627,
'info total genres': 109, 'info total songs': 9618, 'info total duration': 7477020.03200002,
'player count': 4, 'other player count': 0}
```

### About the Python module

#### Parameters for module

See inline documentation in the module file itself - for instance by running this code.
```
from lms_jsonrpc_module import lms_jsonrpc
print(lms_jsonrpc.__doc__)
```

#### Creating a formal Python module accessible via 'pip' etc

It is not currently the intention to put in the additional work to make this a formal Python module accessible by 'pip' or 'conda'. Taking that step requires an ongoing admin effort - but that will not significantly improve the user's experience.

#### Improvements
If you have suggestions as to how this page, and the associated module could be improved, please post into the [Developer forums](https://forums.slimdevices.com/forum/developer-forums/developers) with 'Python' in the subject line. 

## Code examples

### Seeing what the Server returns 

In repsonse to a json query the Server returns a Python dictionary (essentially a json object) containing four items (`params`, `method`, `result`, `id`).

However the `lms_jsonrpc()` function only returns the `result` item by default. If the additional parameter `full_response=True` is passed, then all four items are returned. Doing this can be useful when debugging. 

Code:
```
from lms_jsonrpc_module.py import lms_jsonrpc
myLMS = ('192.168.1.12','9000') # put in values there for your LMS server

the_full_response = lms_jsonrpc(lms=myLMS, cmdlist=['player','count', '?'],full_response=True)
print(f'Full response: {the_full_response}')
result_only = lms_jsonrpc(lms=myLMS, cmdlist=['player','count', '?'])
print(f'Returning the result item only: {result_only}')
print(f'Extracting the data item (the player count) from the result object: {result_only["_count"]}')
```

Response
```
Full response: {'result': {'_count': 4}, 'id': '', 'params': ['-', ['player', 'count', '?']], 'method': 'slim.request'}
Returning the result item only: {'_count': 4}
Extracting the data item (the player count) from the result object: 4
```
### Querying players using the player command

The `player` command can be used to query some of the common player attributes. [Documentation on `player id` command](players.md#player-id).

Code:
```
from lms_jsonrpc_module import lms_jsonrpc
myLMS = ('192.168.1.12','9000') # put in values there for your LMS server

# Get information about how many players, their IDs, and their names
players_count = lms_jsonrpc(lms=myLMS, cmdlist=['player','count', '?'])['_count']
print(f'Number of connected players:{players_count}')
print()

cols = [13,23,30]
heads = ["Player Index", "Player id (Mac Address)", "Player Name"]

print(f'{heads[0]:{cols[0]}}  {heads[1]:{cols[1]}}  {heads[2]:{cols[2]}}' )
print(f'{cols[0]*"-"}  {cols[1]*"-"}  {cols[2]*"-"}')

for p_index in range(players_count):
    p_name= lms_jsonrpc(lms=myLMS, cmdlist=['player', 'name', p_index, '?'])['_name']
    p_id =   lms_jsonrpc(lms=myLMS, cmdlist=['player', 'id', p_index, '?'])['_id']  
    print(f'{p_index:^{cols[0]}}  {p_id:<{cols[1]}}  {p_name:<{cols[2]}}')
```

Response
```
Number of connected players:5

Player Index   Player id (Mac Address)  Player Name                   
-------------  -----------------------  ------------------------------
      0        00:04:20:28:c7:f1        Stalking Horse
      1        00:04:20:2a:e0:74        Runcible Red
      2        00:04:20:2a:c8:20        Scarlet Study
      3        00:04:20:12:ae:f5        Dittography
```


### Use the `players` command for all available info on connected players

The `players` command returns a json object which contains all available information about players. [Documentation on `players` command](players.md#players).

#### players command, full json response
To see what this object looks like, run this code which prints out the full json with minimal formatting.

Code:
```
import json
from lms_jsonrpc_module import lms_jsonrpc
myLMS = ('192.168.1.12','9000') # put in values there for your LMS server
# use 'player' command to get the number of players
playercountcmd = ['player', 'count', '?']
players_count = lms_jsonrpc(lms=myLMS, cmdlist=playercountcmd)['_count']
# Now issue 'players' command to return info on all players as a JSON object
# First parameter (0) is the playerindex of first player to return info about
# Second parameter (players_count) is the number of players
playerscmd = ["players", "0", players_count]
allplayers_json = lms_jsonrpc(lms=myLMS, cmdlist=playerscmd)
print(json.dumps(allplayers_json, indent=4)
```

Response (partial, info about first two players only included)
```
{
"count": 4,
"players_loop": [
 {
            "playerindex": "0",
            "playerid": "00:04:20:28:c7:f1",
            "uuid": "ca1c8fbf2d48cbb1c859b5ea7ce4ecf9",
            "ip": "192.168.5.102:48187",
            "name": "Stalking Horse",
            "seq_no": "183",
            "model": "baby",
            "modelname": "Squeezebox Radio",
            "power": 1,
            "isplaying": 0,
            "displaytype": "none",
            "isplayer": 1,
            "canpoweroff": 1,
            "connected": 1,
            "firmware": "8.5.0-r16962"
        },
        {
            "playerindex": 1,
            "playerid": "00:04:20:2a:e0:74",
            "uuid": "7147ee259b66f5c9c39c0eb14cfefb5c",
            "ip": "192.168.5.101:43170",
            "name": "Runcible Red",
            "seq_no": "241",
            "model": "baby",
            "modelname": "Squeezebox Radio",
            "power": 1,
            "isplaying": 0,
            "displaytype": "none",
            "isplayer": 1,
            "canpoweroff": 1,
            "connected": 1,
            "firmware": "8.5.0-r16962"
        },

```
#### players command, output formatted

Code:
```
from lms_jsonrpc_module.py import lms_jsonrpc
myLMS = ('192.168.1.12','9000') # put in values there for your LMS server

playercountcmd = ['player', 'count', '?']
players_count = lms_jsonrpc(lms=myLMS, cmdlist=playercountcmd)['_count']
playerscmd = ["players", "0", players_count]
allplayers_json = lms_jsonrpc(lms=myLMS, cmdlist=playerscmd)

# Now print out some information about all the players
print(f'Number of players:{allplayers_json["count"]}')

# Some column headings
cols = [8, 18, 14, 20, 25]
heads = ["Index", "id (MAC address)", "firmware", "ip address", "name"]

print(f'{heads[0]:{cols[0]}} {heads[1]:{cols[1]}} {heads[2]:{cols[2]}} {heads[3]:{cols[3]}} {heads[4]:{cols[4]}}' )
print(f'{cols[0]*"-"} {cols[1]*"-"} {cols[2]*"-"} {cols[3]*"-"} {cols[4]*"-"}')

for aplayer in allplayers_json["players_loop"]:
    print(f'{aplayer["playerindex"]:^{cols[0]}} {aplayer["playerid"]:{cols[1]}} {aplayer["firmware"]:{cols[2]}} {aplayer["ip"]:{cols[3]}} {aplayer["name"]:{cols[4]}}')
```

Response:
```
Number of players:4
Index    id (MAC address)   firmware       ip address           name                     
-------- ------------------ -------------- -------------------- -------------------------
   0     00:04:20:28:c7:f1  8.5.0-r16962   192.168.5.102:48187  Stalking Horse
   1     00:04:20:2a:e0:74  8.5.0-r16962   192.168.5.101:43170  Runcible Red
   2     00:04:20:2a:c8:20  8.5.0-r16962   192.168.5.104:56869  Scarlet Study
   3     00:04:20:12:ae:f5  137            192.168.5.103:36396  Dittography
```

### using name command to change name of a player

The `name` command can be used to query the name of a player, and to change its name. [Documentation on `name` command](players.md#name). The `name` command is an example of a player command where the first paramater is the id (= mac address) of the player.

The code example queries the "first" player that the Server sees (the one with Index = 0), and displays information about it. It then changes the name of the player.

Code:
```
from lms_jsonrpc_module.py import lms_jsonrpc
myLMS = ('192.168.1.12','9000') # put in values there for your LMS server

newplayername = "New Player Name"

print("Use the player command to determine MAC address of the player with Index 0")
playerid_index0 = lms_jsonrpc(lms=myLMS, cmdlist=["player", "id", "0", "?"])['_id']
print(f'Player id (=mac address)= {playerid_index0}')

print("Use the name command to determine existing name of player with Index 0")
playername_index0 = lms_jsonrpc(lms=myLMS, player=playerid_index0, cmdlist=["name","?"])['_value']
print(f'Existing name: {playername_index0}')

print(f'Now we change the name of player to: {chr(34)}{newplayername}{chr(34)}')

changenamecmdlist = ["name", newplayername] #command to change player name
changereturn = lms_jsonrpc(lms=myLMS, player = playerid_index0, cmdlist=changenamecmdlist, full_response=True)
print(f'Full response from system: {changereturn}')

print(f'Player name is now: {lms_jsonrpc(lms=myLMS, player = playerid_index0, cmdlist=["name","?"])["_value"]}')

```

Response:
```
Use the player command to determine MAC address of the player with Index 0
Player id (=mac address)= 00:04:20:28:c7:f1
Use the name command to determine existing name of player with Index 0
Existing name: Stalking Horse
Now we change the name of player to: "New Player Name"
Full response from system: {'method': 'slim.request', 'params': ['00:04:20:28:c7:f1', ['name', 'New Player Name']], 'result': {}, 'id': ''}
Player name is now: New Player Name
```