FROM python:3.8.12
RUN apt-get update && apt-get install -y ffmpeg --no-install-recommends
RUN pip install opencv-python
WORKDIR /app
COPY setup_rtmp.py .
CMD ["python", "setup_rtmp.py"]