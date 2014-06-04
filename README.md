Wowza-Metric
============

If you're using Wowza with "edge distribution" you might find this interesting.

Sometimes you have a large number of "Wowza Edge Servers" running, and it's hard to monitoring the connections of these servers.

This is a simple combination of a shell script and a python script, that provides the possibility of send information to AWS CloudWatch.

With these scripts you can send the to AWS CloudWatch, so you'll be able to monitoring each server individually or globally.

You can also configure alarms and set "Auto Scaling" actions based on the metrics you're sending to CloudWatch.

Once you have the scripts properly deployed on your servers you'll just need create a cron task to execute your script every minute, or every 5 minutes, or whenever you want. For example:

    * * * * * /opt/wowza/wowzametric.sh >/dev/null 2>&1

That's it! If you do that you'll be able to check the connections of your "Edge Servers" through the CloudWatch metrics.



----------


**Sample of the Sum of Wowza Edge Connections:**

![Sample of the Sum of Wowza Edge Connections][1]

  
----------


**Sample of the Average Wowza Edge Connections:**

![Sample of the Average Wowza Edge Connectionse][2]


  [1]: https://s3-sa-east-1.amazonaws.com/ciro.anunciacao/git/wowza-metric/wowza-connections-sum.jpg "Sample of the Sum of Wowza Edge Connections"
  [2]: https://s3-sa-east-1.amazonaws.com/ciro.anunciacao/git/wowza-metric/wowza-connections-average.jpg "Sample of the Average Wowza Edge Connections"