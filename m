Content-Type: multipart/mixed; boundary="===============4886206060714719631=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Subject: [PATCH] handsfree-audio: Log when agent (un)register
Date: Fri, 12 Apr 2013 19:29:46 -0300
Message-ID: <1365805786-11726-1-git-send-email-jprvita@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4886206060714719631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit logs on debug level when a Handsfree Audio Agent registers
or unregisters itself and the CODECs that are enabled.
---
 src/handsfree-audio.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 3b0814f..411632e 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -663,6 +663,7 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 	DBusMessageIter iter, array;
 	int length, i;
 	gboolean has_cvsd =3D FALSE;
+	gboolean has_msbc =3D FALSE;
 =

 	if (agent)
 		return __ofono_error_in_use(msg);
@@ -688,6 +689,8 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 		} else if (codecs[i] !=3D HFP_CODEC_MSBC)
 			return __ofono_error_invalid_args(msg);
 =

+		has_msbc =3D TRUE;
+
 		if (defer_setup)
 			has_wideband =3D TRUE;
 	}
@@ -703,6 +706,12 @@ static DBusMessage *am_agent_register(DBusConnection *=
conn,
 	agent->watch =3D g_dbus_add_disconnect_watch(conn, sender,
 						agent_disconnect, NULL, NULL);
 =

+	DBG("Agent %s registered with the CODECs:%s%s", sender,
+		has_cvsd ? " CVSD" : "", has_msbc ? " mSBC" : "");
+
+        if (has_msbc && !has_wideband)
+		DBG("mSBC disabled due to lack of SCO defer setup support");
+
 	return dbus_message_new_method_return(msg);
 }
 =

@@ -731,6 +740,8 @@ static DBusMessage *am_agent_unregister(DBusConnection =
*conn,
 	agent_free(agent);
 	agent =3D NULL;
 =

+	DBG("Agent %s unregistered", sender);
+
 	return dbus_message_new_method_return(msg);
 }
 =

-- =

1.7.11.7


--===============4886206060714719631==--

