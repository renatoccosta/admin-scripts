#!/bin/bash

# Atualizar containers com as novas imagens

sudo docker compose pull
sudo docker compose down
sudo docker compose up -d
