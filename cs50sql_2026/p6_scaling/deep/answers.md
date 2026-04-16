# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

Will the observations likely be evenly distributed across all boats, even if AquaByte most commonly collects observations between midnight and 1am? Why or why not?
-> The observations will be evenly distributed.

Suppose a researcher wants to query for all observations between midnight and 1am. On how many of the boats will they need to run the query?
-> The researcher will need to run the query on all of the boats

to adopt:
Using random distribution will have the benefit of sending more data in total.
It will also be beneficial if, for any reason one boat might have problem with its hard- or software. A data loss will not affect the other boats.

not to adopt:
You will need an equal hard- and software setup on each boat.
Queries will be more complex working with distributed data.


## Partitioning by Hour

Will the observations likely be evenly distributed across all boats, even if AquaByte most commonly collects observations between midnight and 1am? Why or why not?
-> The observations will not be evenly distributed.

Suppose a researcher wants to query for all observations between midnight and 1am. On how many of the boats will they need to run the query?
-> The researcher will need to run the query on only some of the boats.

to adopt:
Since most observation are sent to boat A and C, boat B only needs minimal hard and software if any. This might bring costs down if this is a concern.
If all three boats use an equal setup, then one might have a "backup boat" if one fails.
If you split your crew right, they only need to query one database for their work.

not to adopt:
If data loss occurs on one of the main receivers, the whole data time window might get lost.

## Partitioning by Hash Value

Will the observations likely be evenly distributed across all boats, even if AquaByte most commonly collects observations between midnight and 1am? Why or why not?
-> The observations will be evenly distributed.

Suppose a researcher wants to query for all observations between midnight and 1am. On how many of the boats will they need to run the query?
-> The researcher will likely need to run the query on all of the boats.

Suppose a researcher wants to query for a specific observation, which occurred at exactly 2023-11-01 00:00:01.020. On how many of the boats will they need to run the query?
-> The researcher will need to run the query on only some of the boats.


to adopt:
Since data will be evenly distributed you will have a similar situation as with "Random Partitioning".
Using a hash function might be a more systematic approach than a random distribution. Distribution might be predictable and some queries might be simpler.

not to adopt:
Using hashing might need additional software for validation if data is hashed correctly.
