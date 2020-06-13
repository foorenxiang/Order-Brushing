/ read data from csv
rawData:("fiiz";enlist csv)0:`:order_brush_order.csv

/ change datetime to timespan format
update event_time:`timespan$event_time from `rawData

/ created bucketed raw data
rawDataBucketed: update event_time: 0D01:00:00 xbar event_time from rawData

/ Group by users and shops from bucketed data
bucketedUserIDCount: select orderCount:count userid, event_time by shopid,userid from rawDataBucketed

/ create table with data for overall task output
taskOverallOuput:select userid by shopid from bucketedUserIDCount where orderCount > 2

interimOutput2: select shopid, userid from (update userid:"&"sv/: string userid from taskOverallOuput)

interimOutput1:select shopid, userid from (update userid:0 from rawData)

outputTable: interimOutput1,interimOutput2