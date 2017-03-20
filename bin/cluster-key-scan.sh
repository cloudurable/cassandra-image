#!/usr/bin/env bash
rm ~/.ssh/known_hosts
ssh-keyscan bastion >> ~/.ssh/known_hosts
ssh-keyscan 10.0.1.10 10.0.1.11 10.0.2.10 10.0.2.11 >> ~/.ssh/known_hosts