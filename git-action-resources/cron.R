on:
  schedule:
  - cron: '0 12-23/2 * * *'  # Schedule to run every 2 hours from 12pm to 11pm UTC

on:
  push:
  branches:
  - main  # Change this to the main branch name




key: ${{ runner.os }}-r-${{ hashFiles('**/renv.lock') }}