from initial_game import welcome_screen
from database import create_database, create_and_populate_tables, drop_dabase


## Dropping database because there's an error that ocurrs when try to create a existing db
drop_dabase()
## TODO try catch to check if db was created
create_database()
create_and_populate_tables()
welcome_screen()