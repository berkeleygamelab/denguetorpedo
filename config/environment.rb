# Load the rails application
require File.expand_path('../application', __FILE__)

# Define globally used regexs
USERNAME_REGEX = /^[\w._+-@]{5,15}$/i
EMAIL_REGEX = /[a-z0-9!$#%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!$#%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/

# the different types of event
STORY = 1
PREVENTION_IDEA = 2
SPECIAL_EVENT = 3

# Initialize the rails application
Dengue::Application.initialize!

