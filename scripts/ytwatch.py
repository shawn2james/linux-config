from json import load
from dmenu import show
from os import system

with open('videos.json') as json_file:
    data = load(json_file)

    titles=[vid["title"] for vid in data]
    channels=[vid["uploader"] for vid in data]
    urls=[vid["url"] for vid in data]

    fullNames = [f"{title} => [[{channels[titles.index(title)]}]]" for title in titles]

    choice = show(fullNames, case_insensitive=True, lines=25)
    if choice!=None:
        title = choice[:choice.index(" => [[")]
        system(f"youtube-viewer {urls[titles.index(title)]}")
