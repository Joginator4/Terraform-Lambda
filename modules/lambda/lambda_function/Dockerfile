FROM public.ecr.aws/lambda/python:3.9 as base
COPY src/ ${LAMBDA_TASK_ROOT}
COPY requirements.txt ${LAMBDA_TASK_ROOT}
RUN pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
CMD [ "process_settlement.handler" ]