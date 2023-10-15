# Strategy
- just get something working, and document the assumptions. 
- in version 2 we will change those assuptions from reified to values of a configuration

# Version 1
## Beliefs
  - must be ground
  - don't have time-stamps
  - ignore questions of duplicate beliefs and fluents
### Assert
  - check the belief is ground, and then insert into the bag of beliefs
  - if it's a duplicate, well
    1. we won't know
    2. we don't care
    3. query will retrieve one of the duplicates and we don't know or care which one
