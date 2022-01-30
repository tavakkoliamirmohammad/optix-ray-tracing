import cv2
import time
import subprocess as sp
import glob
import os
import socket
import pickle

img_width = 400
img_height = 400

test_path = '../frames'
# Folder with synthetic sample images.

os.makedirs(test_path, exist_ok=True)  # Create folder

os.chdir(test_path)

ffmpeg_cmd = 'ffmpeg'
# May use full path like: 'c:\\FFmpeg\\bin\\ffmpeg.exe'

img_list = glob.glob("*.ppm")
img_list_len = len(img_list)
img_index = 0

fps = 60

rtsp_server = 'rtmp://rtmp_server:1935/live/stream1'

command = [ffmpeg_cmd,
           '-re',
           '-f', 'rawvideo',  # Apply raw video as input - it's more efficient than encoding each frame to PNG
           '-s', f'{img_width}x{img_height}',
           '-pixel_format', 'rgb24',
           '-r', f'{fps}',
           '-i', '-',
           '-pix_fmt', 'yuv420p',
           '-bufsize', '64M',
           '-maxrate', '4M',
           '-rtsp_transport', 'tcp',
           # '-preset', 'ultrafast',
           '-f', 'flv',
           #'-muxdelay', '0.1',
           rtsp_server
           ]
print(" ".join(command))
# process = sp.Popen(command, stdin=sp.PIPE)  # Execute FFmpeg sub - process
# HOST = "0.0.0.0"  # Standard loopback interface address (localhost)
# PORT = 8080  # Port to listen on (non-privileged ports are > 1023)
# print(f"Running on {HOST}:{PORT}", flush=True)
# RECV_BUFF_SIZE = 1024 * 1024 * 1024 * 4
# frame = 0
# with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
#     s.bind((HOST, PORT))
#     s.listen()
#     conn, addr = s.accept()
#     a = True
#     with conn:
#         print('Connected by', addr, flush=True)
#         while True:
#             data = conn.recv(RECV_BUFF_SIZE)
#
#             if data:
#                 # process.stdin.write(data)  # Write raw frame to stdin pipe.
#                 with open(f"/app/frames/frame_{frame}.ppm", "wb") as f:
#                     f.write(data)
#                     frame += 1
#                     # time.sleep(1 / fps)
#
#
# # while True:
# #     current_img = cv2.imread(img_list[
# #                                  img_index])  # Read a JPEG image to NumPy array( in BGR color format) - assume the resolution is correct.
# #     img_index = (img_index + 1) % img_list_len  # Cyclically repeat images
# #     process.stdin.write(current_img.tobytes())  # Write raw frame to stdin pipe.
# process.stdin.close()  # Close stdin pipe
# process.wait()  # Wait
