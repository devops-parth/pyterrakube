FROM python
WORKDIR /app
COPY c29.py /app
EXPOSE 8080
CMD [ "python","c29.py" ]
