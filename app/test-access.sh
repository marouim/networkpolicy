#!/bin/bash

echo "Test: connexion vers service inventory-service port 9001"
curl --connect-timeout 5 http://inventory-service:9001

echo "Test: connexion vers service billing-service port 9002"
curl --connect-timeout 5 http://billing-service:9002

echo "Test: connexion vers service account-service port 9003"
curl --connect-timeout 5 http://account-service:9003

echo "Test: connexion vers service request-service port 9004"
curl --connect-timeout 5 http://request-service:9004

echo "Test: connexion vers service request-service port 9005"
curl --connect-timeout 5 http://request-service:9005
