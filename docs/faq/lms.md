---
layout: default
title: Lyrion Music Server FAQ
---

### What are logs?

:   Logs are records written by software modules. They generally record significant events and, in particular, problems
    They are often plain text files (and in the case of LMS and related applications, they are almost always plain text).
    
    The level of detail held within the log records is often configurable - with the default level usually only showing detected errors.
    Increasing the log level usually results in more details being reccorded.
    The highest level of logging tends to be very verbose and is typically only used for short periods due to the amount of space conmsumed to store the data.
    
    Log data is usually automatically "rolled over" with the result that old information is discarded. This is to try to prevent storage space becoming full.

> :memo: **Privacy Warning**
Log entries can contain personal information such as user account names and possibly passwords and personal application access keys.
So do not simply upload a full log file or copy/paste into a forum post without first checking the content and possibly replacing such material first.
---

### How can logs be accessed?

:   Each software application has its own way of recording and presenting log information.
    The individual log file entries can be very wide so viewing on a device with a small screen is not recommended.
    
- LMS:
    
    Log data is stored in server.log and scanner.log  
    The location of these files is not the same for all installations, however, the location does not usually matter because LMS includes a log file viewer.  
    For example:  
    From the LMS "Default" web interface - Choose Settings (bottom right) then Information then links to the log files are shown at the bottom of the page.  
    The built-in log viewer will automatically update the view as new entries are added. If this means that what you were studing suddently scrolls off the page then
    you can turn off the refresh function with a checkbox towards the top of the page.
    
    From the LMS "Material" web interface - at the time of writing this ... it could not be found!

- piCorePlayer:

    If you are using piCorePlayer (pCP) then you can use the log viewer that is included in its web interface.  
    From the "Main" tab select "Diagnostics" and then the "Logs" tab.  
    There is a drop down menu on that page that you can use to select a particular log type.  
    server/server is the LMS server.log, server/scanner is the LMS scanner log. Note - these logs can be very long.
    
### How is the level of detail in the logs adjusted?

:   Changing the level of detail in the logs is usually done following guidance of someone who is helping to resolve a problem.  
    Including a lot of diagnostic detail in the log can sometimes generate so much information that it is difficult to read and understand.  
    Changing the logging level often requires a restart of the application - although not in the case of LMS.  

- LMS:
    From the LMS web interface you can change the loging level for many different components.
    To access the log level settings go to:  
    "Default" interface: bottom right Settings / Advanced / Logging  
    "Material" interface: top left menu selector (hamburger) / Server (bottom of list) / logging  
    
    Each item has a setting with an ascending level of detail - Fatal, Error, Warn, Info, Debug  
    Setting to Warn will include Fatal, Error and Warn levels
    
    There is ad additional setting shown at the top of the page that can be useful.  
    "Save logging settings for use at next application restart"  
    If this is selected then changes made to the logging settings will be remembered for the next restart.
    This helps when the problem that is being researched is something that happens during the restart process.
    
    Do not forget to reset the log levels after diagnosing an issue otherwise you risk filling up the storage if running on a system with limited capacity.
    
    
### Why is my frequently asked question not answered here?

:   That is a good question.
    Probably this is because people who know the answer have answered it somewhere else many times over and did not think of adding it to a FAQ and answering by linking to the FAQ entry.
    
    It might also be because your question is too hard to answer despite everyone and their dogs asking it.


### Why does this FAQ contain mildly humorous comments?

:   FAQ contents are often written by people who would rather be doing something else.
    Injecting a bit of humour lightens the load when creating the entries and might make it more fun for the reader
    who has probably been struggling for some time before finally arriving at the FAQ.

    Some readers might find it condescending but it is not the intention. If you do then you could either lighten up or submit edits.

