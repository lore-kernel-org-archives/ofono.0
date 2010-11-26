Content-Type: multipart/mixed; boundary="===============2451262652483702368=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] call-volume: Remove atom registered check
Date: Fri, 26 Nov 2010 06:58:07 -0800
Message-ID: <1290783487-5579-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2451262652483702368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-volume.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/src/call-volume.c b/src/call-volume.c
index dd1be92..c448d32 100644
--- a/src/call-volume.c
+++ b/src/call-volume.c
@@ -62,9 +62,6 @@ void ofono_call_volume_set_speaker_volume(struct ofono_ca=
ll_volume *cv,
 =

 	cv->speaker_volume =3D percent;
 =

-	if (__ofono_atom_get_registered(cv->atom) =3D=3D FALSE)
-		return;
-
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_CALL_VOLUME_INTERFACE,
 						"SpeakerVolume",
@@ -79,9 +76,6 @@ void ofono_call_volume_set_microphone_volume(struct ofono=
_call_volume *cv,
 =

 	cv->microphone_volume =3D percent;
 =

-	if (__ofono_atom_get_registered(cv->atom) =3D=3D FALSE)
-		return;
-
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_CALL_VOLUME_INTERFACE,
 						"MicrophoneVolume",
@@ -96,9 +90,6 @@ void ofono_call_volume_set_muted(struct ofono_call_volume=
 *cv, int muted)
 =

 	cv->muted =3D muted;
 =

-	if (__ofono_atom_get_registered(cv->atom) =3D=3D FALSE)
-		return;
-
 	m =3D muted;
 	ofono_dbus_signal_property_changed(conn, path,
 						OFONO_CALL_VOLUME_INTERFACE,
-- =

1.7.0.4


--===============2451262652483702368==--

