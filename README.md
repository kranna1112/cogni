# Cognizant Empowered

This application is specifically built for [Bristol Global](http://www.bristolglobal.com) to enable them to manage the 
global relocation activity of [Cognizant](http://www.cognizant.com). The initial code base was 
inspired from Notion Labs' applications Insight Remote and Collabative.

## Copyright & License
- Intellectual Property Owner: Notion Labs, Inc.
- Licensed to: Bristol Global (Perpetual)

## Hosting
The production application is hosted on Heroku and can be accessed directly via cognizantempowered.com.

# Application Overview
## Users
- Cognizant Employees
- Cognizant Project Managers
- Cognizant Mobility/HR resources
- Bristol Global
- Mobility Empowered (System Admin)

## Integration
The Cognizant Empowered application integrates directly with the Mobility Empowered Supply Chain application via API. This 
integration is two-way in the sense that both applications leverage data/models from the other. This integration is primarily
accomplished via the ActiveRestClient gem.

## Domains
- cognizant subdomain (only accessible by user accounts that are associated with the Cognizant organization with the role = employee
- admin subdomain (only accessible by user accounts that are marked as a super admin)
- www (accessible by all users except employee users)

## Development Requiements
- set up local server that can handle subdomains (like pow for Macs)
