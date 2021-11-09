import youtube_dl
from os import listdir, system

playlist = "https://www.youtube.com/playlist?list=PLcXOGPIImO70Uy0MZ8pz0yuzqGccttClJ"


with youtube_dl.YoutubeDL({"ignoreerrors": True, "quiet": True}) as ydl:
    playlist_dict = ydl.extract_info(playlist, download=False)

    downloads = []
    for vid in listdir("/home/shawn/yt"):
        if(vid.endswith(".webm")):
            downloads.append(vid[:-5])

    videos = []
    for video in playlist_dict["entries"]:
        title = video["title"].replace("|", "_").replace(":", " -").replace("?", "")
        channel = video["uploader"]
        fullName = f"{title} ({channel})"

        videos.append(fullName)

    for download in downloads:
        if download not in videos:
            fileName = download.replace(" ", r"\ ").replace("(", r"\(").replace(")", r"\)").replace("'", r"\'")
            print(f"Removing {download}...")
            system(f"rm -f $HOME/yt/{fileName}* && exit 0 || exit 1")
