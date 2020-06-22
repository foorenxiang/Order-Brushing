/ read data from csv
rawData:("fiin";enlist csv)0:`:order_brush_order.csv

/ created bucketed raw data
rawDataBucketed: update event_time: 0D01:00:00 xbar event_time from rawData

/ Group by users and shops from bucketed data
bucketedUserIDCount: select orderCount:count userid, event_time by shopid,userid from rawDataBucketed

/ create table with data for overall task output
taskOverallOuput:select userid by shopid from bucketedUserIDCount where orderCount > 2

/ table with placeholder userid values = 0 to retain all shopid in the output table
interimOutput1:select shopid, userid from (update userid:0 from rawData)

/ table with suspect shops and userids
interimOutput2: select shopid, userid from (update userid:"&"sv/: string userid from taskOverallOuput)

/ create output table by joining placeholder table with table containing actual values
show outputTable: interimOutput1,interimOutput2
