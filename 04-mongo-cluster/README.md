# Mongo Cluster

## Goals

- Deploy 4 Ubuntu 18.04 droplets in DigitalOcean
- On three droplets, install MongoDB
- On one droplet:
    - Take the IP addresses of the other three droplets
    - Provision a small app that will take the three MongoDB instances in the other droplets and use them to form a cluster, with one instance being a primary and the other two as replicas