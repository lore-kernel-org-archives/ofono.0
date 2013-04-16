Content-Type: multipart/mixed; boundary="===============7698799084464664102=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Subject: [PATCH] handsfree-audio: Log when agent (un)register
Date: Tue, 16 Apr 2013 19:32:21 -0300
Message-ID: <1366151541-30242-1-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1365805786-11726-1-git-send-email-jprvita@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7698799084464664102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit logs on debug level when a Handsfree Audio Agent registers
or unregisters itself and the CODECs that are enabled.
---
 src/handsfree-audio.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index c24e787..dc37853 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -674,10 +674,16 @@ static DBusMessage *am_agent_register(DBusConnection =
*conn,
 			return __ofono_error_invalid_args(msg);
 	}
 =

+	DBG("Agent %s registered with the CODECs:%s%s", sender,
+		has_cvsd ? " CVSD" : "", has_msbc ? " mSBC" : "");
+
 	if (has_msbc && defer_setup =3D=3D 1)
 		has_wideband =3D TRUE;
-	else
+	else {
 		has_wideband =3D FALSE;
+		DBG("Wideband speech disabled: %s", has_msbc ?
+			"no SCO defer setup support" : "no mSBC support");
+	}
 =

 	if (has_cvsd =3D=3D FALSE) {
 		ofono_error("CVSD codec is mandatory");
@@ -718,6 +724,8 @@ static DBusMessage *am_agent_unregister(DBusConnection =
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


--===============7698799084464664102==--

