from setup import setup_environment
import warnings

# Make PostgreSQL Connection
engine = setup_environment.get_database()
try:
    con = engine.raw_connection()
    warnings.warn(con)
except:
    pass