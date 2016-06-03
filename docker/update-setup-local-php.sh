#!/bin/bash

dockerize -delims "<%:%>" -template /setup.local.php.tmpl:/app/setup.local.php
