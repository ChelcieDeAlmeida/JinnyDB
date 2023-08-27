# JinnyDB

JinnyDB is a Natural Language to Databases (NLIDB) application powered by LangChain and GPT 3.5 Turbo model that allows users to prompt their database using natural language to retrieve data from their databases

This experiment is based on my research paper which you can read [here](https://github.com/ChelcieDeAlmeida/JinnyDB/tree/main/research_paper). 

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [TO DO](#todo)

## Installation

Once you download this repo, run the following command from the project directory.

```pip install -r requirements.txt```

I used .env files for my environment set up but you can do as you please.

You will need an account with OpenAI if you plan on using the GPT-3.5-Turbo-16K model but any suitable model should work fine. 

## Usage

This experiment used two databases through postgres:
- AdventureWorks [Download Here](https://github.com/lorint/AdventureWorks-for-Postgres)
- Bookings  [Download Here](https://postgrespro.com/docs/postgrespro/10/demodb-bookings)

Note that I modified these databases to have it work for my purpose, you may choose to do the same or work on your own databases
but should you decide that you'd like to do work on this exact project then you may find the queries I used in the db folder of this repo.

Some of the changes I made to the data:
- AdventureWorks
    - Migrated all the tables into a single schema called 'Prod' 
    - Dropped the views that were built with the db
- Bookings
    - I converted the coordinates column in the airports_data table from point to text (my use case at the moment doesn't call for it)
    - separated the coordinates column to longitude and latitude
    - This isn't advisable if you intend to use them, Point is a better data type for coordinates (PostGIS is even better if you're interested in spatial data)


Below are a list of tasks, nonexhaustive that I intend on completing but feel free to participate if you'd like

## TO DO:
- [ ] Build Backend
- [ ] Build frontend on React
- [ ] Add template logic for dialect/user input/database object definitions
- [ ] Integrate intermediate steps
- [ ] Add logic to re-run when """OutputParserException: Could not parse LLM output: `I now know the final answer.`"""
- [ ] Caching based on accuracy
- [ ] Add logic to handle case sensitivity on input values
- [ ] Add logic to store SQLChatMessageHistory in DB and clear session memory from DB
- [ ] Prompt users to choose their Database and add connection variables