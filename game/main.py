from setup import setup_environment
import logging

log = logging.getLogger(__name__)

def start():
    # Make PostgreSQL Connection
    try:
        params = setup_environment.get_database_params()
        while True:
            print("Running params: ", params)
    except:
        pass


if __name__ == '__main__':
    start()