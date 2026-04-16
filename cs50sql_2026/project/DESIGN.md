# Design Document

By Jim Liero

Video overview: <[URL HERE](https://youtu.be/olLky6zqaok)>

## Scope

In this section you should answer the following questions:

* What is the purpose of your database?
The database can be used for planning and keeping an overview on trips to holy sites when visiting Tokyo. Special emphasis was laid on supporting the collection of goshuin stamps.

* Which people, places, things, etc. are you including in the scope of your database?
The database basically includes site seeing trips with date to holy sites in Tokyo.
Each trip has a planned date as well as assigned holy sites.
If a site was visited or not can be tracked using boolean values.
If the site offers a goshuin in can be tracked if the stamp was collected or not.
Each holy site is stored with its name, location (district), religion and its type (temple or shrine) as well as information on whether or not the site has a goshuin.

* Which people, places, things, etc. are *outside* the scope of your database?
The database only includes data on trips to holy sites within Tokyo.
No other places, things or persons are included.

## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?
The user should be able to plan trips to holy sites in Tokyo and to easily get an overview of prior ones.
They can keep track on previous and upcoming trips.
If the user collects goshuin the user will be able to keep track on the current collection.
The user can create reports such as: planned trips by district, holy sites not yet visited, and completed goshuin collections.

* What's beyond the scope of what a user should be able to do with your database?
Holy sites outside Tokyo are not included in the database.
Features on holy sites like
temizuya (ritual purification fountains), spiritual power spots,
komainu (guardian dogs), buddha statues or pagodas
are not part of the database.

## Representation

Entities are captured in SQLite tables with the following schema.

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?
The database represents four main entities:
district - administrative areas of Tokyo where holy sites are located
holy_site - temples and shrines the user plans to visit
date_trip - planned visits to districts on specific dates
site_trip - a junciton entity linking holy sites to specific trips, tracking visit details

* What attributes will those entities have?
district
- id - unique identifier for each district
- name - districts name e.g. Shibuya

holy_site
- id - unique identifier for each holy_site
- name - site name e.g. Senso-ji
- type - classification as either temple or shrine
- religion - the religion practiced at the site
- has_goshuin - boolean indicating if site offers goshuin stamps
- district_id - foreign key linking to the site's district

date_trip
- id - unique identifier for each date_trip
- district_id - Foreign key indicating which district is being visited
- planned_for - date the trip is planned for (format: yyyy-mm-dd)

site_trip
- id - unique identifier for each site_trip
- trip_id - foreign key linking to the date trip
- site_id - foreign key linking to the holy site
- visited - boolean indicating if site was actually visited
- got_goshuin - text indicating if a goshuin stamps was collected if offered

* Why did you choose the types you did?
INTEGER are used for ids to provide fast and efficient indexing.
TEXT for names and dates since there offer a variable lenght.
TEXT for dates since sqlite3 does not have a dedicated date type for dates.
TEXT is also used for got_goshuin, even thought it could have been boolean, since a third state was needed in order to clearly distinguishe between sites that offer a stamps and those that do not when tracking the collection.
Boolean are used when states are binary like on holy_site.has_goshuin or site_trip.visited.

* Why did you choose the constraints you did?
PRIMARY KEY on id columns ensures that each record is uniquely identifiable.
UNIQUE on district.name and holy_site.name prevents duplictate entries in the database.
NOT NULL usage prevents missing or unassigned data when planning or tracking.
FOREIGN KEY are used to maintain data integrity by ensuring that referenced entries exist.
DEFAULT values are used to improve the users workflow with the database.
CHECKs are used to restrict and maintain format of entries.

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

![entity relationship diagram](diagramm)
created using https://mermaid.js.org/ on 02.03.2026 - 19:58

Each date_trip is a planned visit to exactly one district. One district can be visited on zero or many date_trips. It is assumed that the user might take multiple visits to one district on different dates.

Each date_trip includes zero or many site_trip entries. Each site_trip belongs to exactly one date_trip.
It is assumed that the user will visit multiple holy sites during one date_trip.

Each holy_site can be visited in zero or many site_trips. Each site_trip references exactly one holy_site.
This allows the same holy_site to be visited on different dates, tracking the user's repeated visits over time.

Each district contains one or many holy_sites. Each holy_site belongs to exactly one district as its location.
Sites that are extraordinarily large and might span multiple districts are stored according to their official address and therefore maintain only one district relation.

## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?
In order to speed up operations, four indexes were created on foreign key columns:
- trip_districtId
- holySite_districtId
- siteTrip_tripId
- siteTrip_siteId

Without the indexes, the database would need to scan the entire tables when JOINs are used.
Indexes on district.name and holy_site.name are not needed.
The UNIQUE constraints automatically create indexes for those columns.

Five views were created to simplify common queries:
- trips_to_district - table that shows all trips that have a date and the target districts name
- planned_not_visited - table that shows all trips that have a date as well information of the site but that were not taken yet - 'visited' is false
- not_planned_for_trip - table that shows holy site along with district that are not assigned for a trip
- collected_goshuin - table that shows the name and type of all holy sites the user has a goshuin from
- holy_sites_has_goshuin - table that shows the name and district of all holy sites that offer a goshuin

Five triggers were created to support data integrity and user experiance:
Trigger 1: check_date_format_insert
Validates date format when inserting new records into date_trip table

Trigger 2: check_date_format_update
Validates date format when updating the planned_for column in date_trip table

Trigger 3: check_gotGoshuin_visitedTrue
Prevents setting got_goshuin to 'yes' if the site wasn't visited

Trigger 4: update_hasGoshuin_gotGoshuin
Updates related site_trip records when a holy site starts offering goshuin

Trigger 5: default_goshuin_on_insert
Corrects the default value for got_goshuin based on whether the holy site actually offers goshuin

## Limitations and future work/improvement

In this section you should answer the following questions:

* What are the limitations of your design?
Not user accounts: The current design does not feature user accounts. It is assumed that a single user works with the database.
Not feature tracking: Some holy sites might have additional features like pagodas, fountains, guardian or buddha statues. None of these are included.
No goshuin design tracking: Sites might offer different stamps (special edition, seasonal). These designs cannot be tracked.
No time tracking: The current design only enables date planning and tracking but not time.
Multidistrict sites: Even though some sites might be large enough to span multiple districts and have multiple entrances, the current design does not take this into account.

* What might your database not be able to represent very well?
Missing Comment function: The current design does not offer a way to comment trips. The user is not able to store information like "The site was great but I could not find the stamps". This should be Updated in the future.
Trip planning flexibility: Each Trip is tied to a single district. In reality, a day trip might also cover holy sites in adjacent districts. In the current design, this would require creating separate trips.
Trip planning options: The current design features a binary approach to tracking trips. The user either visited or not. In reality the user might plan with different options for a specific trip (e.g. backup sites, weather-dependent choices). These options cannot be taken into consideration when planning with the current design.
Updatability can be improved: The current design does not provide a simple way to insert or update holy sites. It was assumed that the database will setup once with a complete dataset and that the user will not insert additional sites.
Boolean values: Since sqlite converts TRUE and FALSE to 1 and 0, it might be easier for a the user to use TEXT instead of boolean values.
Usability for none-technical users: A propper GUI written in python with FLASK might be the biggest overall improvement for usability for this project. So none technical user can work with the database. Naming of views could be improved for usability as well.
