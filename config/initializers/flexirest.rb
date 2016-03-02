require 'api-auth'
@access_id = 2
@secret_key = 'ljU8faGzaj9ULImSYP/nnHjQIaD9i5gotVEzrXIKWUGIk7M4Io1oIXNLA55qh8b910oThn8nsnr4vfT6t9qOOw=='

Flexirest::Base.api_auth_credentials(@access_id, @secret_key)