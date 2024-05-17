from podping_schemas.org.podcastindex.podping.podping_pjs import Podping

podping_03 = Podping.from_json("""{
    "url": "https://feeds.buzzsprout.com/1570027.rss"
}""")

print(podping_03)
print(podping_03.url)

podping_11 = Podping.from_json("""{
    "version": "1.1",
    "medium": "podcast",
    "reason": "update",
    "iris": [
        "https://feeds.redcircle.com/312fdb8b-3ecc-4ba1-b55c-a18346aaa21f",
        "https://feeds.buzzsprout.com/960496.rss",
        "https://feeds.buzzsprout.com/1925314.rss"
    ],
    "timestampNs": 1715913016021063200,
    "sessionId": 13766531295822504000
}""")

print(podping_11)
print(podping_11.medium)
print(podping_11.reason)
for iri in podping_11.iris:
    print(iri)
