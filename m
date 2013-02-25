Content-Type: multipart/mixed; boundary="===============7534823842039573925=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 1/8] handsfree-audio: Add atom modem tracking
Date: Mon, 25 Feb 2013 11:34:14 -0300
Message-ID: <1361802861-18267-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361802861-18267-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7534823842039573925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds atom watch for handsfree modem in order to be able to
register the Handsfree Audio Card.
---
 src/handsfree-audio.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 4e2cf93..a8680b1 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -51,6 +51,7 @@ struct agent {
 };
 =

 static struct agent *agent =3D NULL;
+static unsigned int modemwatch_id;
 static int ref_count =3D 0;
 =

 static void agent_free(struct agent *agent)
@@ -171,6 +172,20 @@ static const GDBusMethodTable am_methods[] =3D {
 	{ }
 };
 =

+static void handsfree_modem_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *user_data)
+{
+}
+
+static void modem_watch(struct ofono_modem *modem, gboolean added, void *u=
ser)
+{
+	if (added =3D=3D FALSE)
+		return;
+
+	__ofono_modem_add_atom_watch(modem, OFONO_ATOM_TYPE_HANDSFREE,
+					handsfree_modem_watch, modem, NULL);
+}
+
 void ofono_handsfree_audio_ref(void)
 {
 	ref_count +=3D 1;
@@ -180,8 +195,12 @@ void ofono_handsfree_audio_ref(void)
 =

 	if (!g_dbus_register_interface(ofono_dbus_get_connection(),
 					"/", HFP_AUDIO_MANAGER_INTERFACE,
-					am_methods, NULL, NULL, NULL, NULL))
+					am_methods, NULL, NULL, NULL, NULL)) {
 		ofono_error("Unable to register Handsfree Audio Manager");
+		return;
+	}
+
+	modemwatch_id =3D __ofono_modemwatch_add(modem_watch, NULL, NULL);
 }
 =

 void ofono_handsfree_audio_unref(void)
@@ -196,6 +215,8 @@ void ofono_handsfree_audio_unref(void)
 	if (ref_count > 0)
 		return;
 =

+	__ofono_modemwatch_remove(modemwatch_id);
+
 	g_dbus_unregister_interface(ofono_dbus_get_connection(), "/",
 						HFP_AUDIO_MANAGER_INTERFACE);
 =

-- =

1.7.11.7


--===============7534823842039573925==--

