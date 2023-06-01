#  **ssl-grade-checker**

This script is part of a work project to automate the scanning of production URLs and report the resulting grades that SSL-Labs gives out

Provide a list of urls and the container will iterate through it and generate results for each, this process can take a while, anywhere from 2-5 minutes per site in my experience.

Results are output in k : v pairs, e.g `example.com : A` so that they can be easily processed by another step.
