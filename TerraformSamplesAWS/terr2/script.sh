#!/bin/bash
amazon-linux-extras install nginx1
for i in nginx; do service $i start; done
