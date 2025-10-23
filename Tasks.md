# Tasks for evaluating candidates

## General

We don't expect you to spend too much time on these tasks. We haven't tested
the time it takes to perform all tasks and they may take much too long. You can
also describe how you would perform the tasks rather than implement them.
Please report also the time you spend with these tasks. Task 3 and 4 are therefore marked optional,
try to describe at least one of those. Please return the tasks by the deadline including results
and intermediate steps.

## Tasks

### Task 1

The function `pi_opso` is much too slow. While we are not allowed to touch that function,
we might use precomputed values. Please store the results of `pi_opso` in a compliant netcdf file,
allow optional recreation of this netcdf file and make sure that this file gives correct
results whereever used.

### Task 2

Create a python notebook presenting values of jitter_sin. This should only visualize the general
functionality of jitter_sin and does not need to use the actual output.

### Task 3 (optional)

The visualization of jitter_sin should be put on a OGC-EDR compliant web-server for external partners.
Please provide an easy way to install it on our existing web-server.

### Task 4 (optional)

Train an ML-model on the output of jitter_sin. Evaluate the differences between the AI-model and
the current implementation.
