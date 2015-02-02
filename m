Content-Type: multipart/mixed; boundary="===============1430537786469228426=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: [PATCH 2/2] handsfree-audio: Init and cleanup audio manager on
 ref/unref calls
Date: Mon, 02 Feb 2015 14:43:06 +0200
Message-ID: <1422880986-11262-3-git-send-email-tommi.kenakkala@tieto.com>
In-Reply-To: <1422880986-11262-1-git-send-email-tommi.kenakkala@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1430537786469228426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/handsfree-audio.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 6f69fb3..14f65dc 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -845,6 +845,8 @@ void ofono_handsfree_audio_ref(void)
 	if (ref_count !=3D 1)
 		return;
 =

+	__ofono_handsfree_audio_manager_init();
+
 	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
 					OFONO_MANAGER_PATH,
 					HFP_AUDIO_MANAGER_INTERFACE,
@@ -873,6 +875,8 @@ void ofono_handsfree_audio_unref(void)
 		agent_release(agent);
 		agent_free(agent);
 	}
+
+	__ofono_handsfree_audio_manager_cleanup();
 }
 =

 int __ofono_handsfree_audio_manager_init(void)
@@ -882,15 +886,11 @@ int __ofono_handsfree_audio_manager_init(void)
 =

 void __ofono_handsfree_audio_manager_cleanup(void)
 {
-	if (ref_count =3D=3D 0)
+	if (ref_count !=3D 0)
 		return;
 =

-	ofono_error("Handsfree Audio manager not cleaned up properly,"
-			"fixing...");
-
-	ref_count =3D 1;
-	ofono_handsfree_audio_unref();
-
-	if (sco_watch > 0)
+	if (sco_watch > 0) {
 		g_source_remove(sco_watch);
+		sco_watch =3D 0;
+	}
 }
-- =

1.7.9.5


--===============1430537786469228426==--

