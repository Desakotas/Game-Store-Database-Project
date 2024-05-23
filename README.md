# Game-Store-Database-Project

### Database Purpose
The purpose of this database is to maintain the data used to support customer game purchases and analyze store operational performance. It will be used by store employees only.

### Business Problems Addressed
- Enable the video game store to create detailed sales reports, breaking down sales trends by game, platform, and publisher to optimize sales strategies.
- Provide data for inventory management to ensure that supply meets demand across different games and platforms, preventing overstocking or stockouts.
- Offer insights for targeted promotions by analyzing customer preferences and purchase histories, allowing for personalized marketing campaigns.
- Enhance customer service by using sales and preference data to provide recommendations, improving customer satisfaction and loyalty.

### Business Rules
- Each Order is placed by one Customer.
- Each Order is processed by one Employee.
- Each Order will have one Payment record.
- Each Order may have one or more Games.
- A Customer may have one or more Orders.
- An Employee may process one or more Orders.
- A Payment record is related to one Order.
- A Game may appear in one or more Orders.
- Each Game is developed by one Developer.
- Each Game is published by one Publisher.
- Each Game is categorized under one Genre.
- Each Game is available on one or more Platforms.
- Each Game can have one Inventory record.
- A Developer can develop one or more Games.
- A Publisher can publish one or more Games.
- A Genre can encompass one or more Games.
- A Platform can support one or more Games.
- An Inventory record will have one Game.
- A Customer will have one Preference record.
- Each Preference record will have one Customer.
- Each Preference record will have one Genre and one Publisher.

### Design Requirements 
- Use Crow's Foot Notation.
- Specify the primary key fields in each table by specifying PK beside the fields.
- Draw a line between the fields of each table to show the relationships between each table.
- Specify which table is on the one side of the relationship by placing a one next to the field where the line starts.
- Specify which table is on the many sides of the relationship by placing a crow's feet symbol next to the field where the line ends.

### Database Implementation
- Implemented the database schema using SQL DDL statements.
- Created three views for reporting purposes.
- Implemented triggers to prevent order processing when ordered quantity exceeds available inventory.
- Added computed columns to calculate customer age from birthdate.
- Applied column encryption to the PhoneNumber column in the Customer table for privacy protection.

