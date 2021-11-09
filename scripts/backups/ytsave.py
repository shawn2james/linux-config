import youtube_dl
from os import system

playlist = "https://www.youtube.com/playlist?list=PLcXOGPIImO70Uy0MZ8pz0yuzqGccttClJ"

with youtube_dl.YoutubeDL({"ignoreerrors": True, "quiet": True}) as ydl:
    playlist_dict = ydl.extract_info(playlist, download=False)

    options = ""
    for video in playlist_dict["entries"]:
        options += f"{video['title']} - {video['channel']}\n"
