import logging
import config
import os

os.makedirs(config.LOGGER, exist_ok=True)
PATH = os.path.join(config.LOGGER, config.LOG_FILE)

logging.basicConfig(
    filename=f"{PATH}",
    level=config.LOG_LEVEL,
    format="%(asctime)s - %(levelname)$ - %(message)s"
)

