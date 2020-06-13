rawData:("fiiz";enlist csv)0:`:order_brush_order.csv

cols rawData

/ no filter, purely group by user and shop
userIDCount: select orderCount:count userid, event_time by shopid,userid from rawData

/ suspectUserID: select from userIDCount where orderCount>2
/ cols userIDCount

/ find repeated order by users in each shop
select shopid, userid from userIDCount where orderCount > 2

/ find repeated order by users in each shop, bucketed by 1 hr (60 mins)
select shopid, userid by 60 xbar event_time from userIDCount where orderCount > 2

/ select last price, sum size by 10 xbar time.minute from trade where sym=`IBM
/ userIDCount: select count userid by shopid from rawData
