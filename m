Content-Type: multipart/mixed; boundary="===============2591726533212279009=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] audio-settings: Remove unwanted check
Date: Fri, 26 Nov 2010 04:27:42 -0800
Message-ID: <1290774462-22195-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2591726533212279009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/audio-settings.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/src/audio-settings.c b/src/audio-settings.c
index bf00c54..ed3e7d1 100644
--- a/src/audio-settings.c
+++ b/src/audio-settings.c
@@ -132,7 +132,7 @@ int ofono_audio_settings_driver_register(const struct o=
fono_audio_settings_drive
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	if (!d || !d->probe)
+	if (!d->probe)
 		return -EINVAL;
 =

 	g_drivers =3D g_slist_prepend(g_drivers, (void *) d);
@@ -144,9 +144,6 @@ void ofono_audio_settings_driver_unregister(const struc=
t ofono_audio_settings_dr
 {
 	DBG("driver: %p, name: %s", d, d->name);
 =

-	if (!d)
-		return;
-
 	g_drivers =3D g_slist_remove(g_drivers, (void *) d);
 }
 =

-- =

1.7.0.4


--===============2591726533212279009==--

