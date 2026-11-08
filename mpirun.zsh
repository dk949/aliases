#!/bin/sh

# mpirun aliases

alias mpirun='mpirun --mca opal_warn_on_missing_libcuda 0 --mca mca_base_component_show_load_errors 0 --oversubscribe'
