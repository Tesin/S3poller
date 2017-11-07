# S3poller

This service is a substitute for the S3 bucket events system.
It watches for new or updated files in an S3 bucket then adds a message on an AWS
SQS queue. I felt this was necessary because S3 bucket events only support sending
messages to standard SQS queues and not FIFO queues. Unfortunately the standard queues
have proven to be inefficient without application code checking for duplicates. Also
the timing of message delivery seems to vary wildly. With this service the FIFO queues
can be leveraged for greater reliability. This is a stop-gap measure for a project.

## Set these environment variables

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- S3_BUCKET
- S3_POLLER_REGION

## Dependencies
- System package: erlang-xmerl
- Elixir 1.5.1
- Erlang/OTP 20
