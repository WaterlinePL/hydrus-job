FROM hyperflowwms/montage2-alpine-node-12:montage5.0-patched

RUN apk update
RUN apk add gfortran
# TODO: instead, compile under alpine
RUN apk add libc6-compat
RUN echo "/workspace" >> LEVEL_01.DIR

# Version of the job executor should be passed via docker build, e.g.: 
# docker build --build-arg hf_job_executor_version="v1.0.16""
ARG hf_job_executor_version
ENV HYPERFLOW_JOB_EXECUTOR_VERSION=$hf_job_executor_version

RUN npm install -g @hyperflow/job-executor@${HYPERFLOW_JOB_EXECUTOR_VERSION}

COPY hydrus hydrus
RUN chmod +x hydrus

# TODO: find out why it does not work
# COPY sample/ workspace/ 
# CMD ["./hydrus"]
