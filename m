Content-Type: multipart/mixed; boundary="===============0906428035529304781=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/2] Fix should invoke microphone_volume instead of
 speaker_volume
Date: Wed, 11 Nov 2009 21:32:07 +0800
Message-ID: <1257946327.31013.2.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0906428035529304781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-volume.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/call-volume.c b/src/call-volume.c
index 301d40d..5555091 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -271,7 +271,7 @@ static DBusMessage *cv_set_property(DBusConnection
*conn, DBusMessage *msg,
 =

 		cv->pending_volume =3D percent;
 		cv->pending =3D dbus_message_ref(msg);
-		cv->driver->speaker_volume(cv, percent, mv_set_callback, cv);
+		cv->driver->microphone_volume(cv, percent, mv_set_callback, cv);
 =

 		return NULL;
 	} else if (g_str_equal(property, "Muted") =3D=3D TRUE) {
-- =

1.6.2.5




--===============0906428035529304781==--

