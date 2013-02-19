Content-Type: multipart/mixed; boundary="===============2691393960308602654=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 07/11] hfp_audio: Add repeated Agent registration
 verification
Date: Tue, 19 Feb 2013 17:44:48 -0300
Message-ID: <1361306692-959-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1361306692-959-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2691393960308602654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

This patch checks if the Handsfree Audio Manager already has an agent
registered for the same owner and object path.
---
 plugins/hfp_audio.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_audio.c b/plugins/hfp_audio.c
index db21a5d..32ddebc 100644
--- a/plugins/hfp_audio.c
+++ b/plugins/hfp_audio.c
@@ -25,6 +25,7 @@
 =

 #include <errno.h>
 #include <stdio.h>
+#include <string.h>
 =

 #include <gdbus.h>
 =

@@ -35,12 +36,34 @@
 =

 #define HFP_AUDIO_MANAGER_INTERFACE		OFONO_SERVICE ".HandsfreeAudioManager"
 =

+struct agent {
+	char *owner;
+	char *path;
+	unsigned char *codecs;
+	int codecs_len;
+};
+
 /* Supported agents codecs */
 enum hfp_codec {
 	HFP_CODEC_CVSD =3D 0x01,
 	HFP_CODEC_MSBC =3D 0x02,
 };
 =

+static GSList *agents =3D NULL;
+
+static int agent_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct agent *agent =3D a;
+	const struct agent *match =3D b;
+	int ret;
+
+	ret =3D strcmp(agent->owner, match->owner);
+	if (ret !=3D 0)
+		return ret;
+
+	return strcmp(agent->path, match->path);
+}
+
 static DBusMessage *am_get_cards(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -52,11 +75,14 @@ static DBusMessage *am_get_cards(DBusConnection *conn,
 static DBusMessage *am_agent_register(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	const char *path;
+	struct agent match, *agent;
+	const char *sender, *path;
 	unsigned char *codecs;
 	DBusMessageIter iter, array;
 	int length, i;
 =

+	sender =3D dbus_message_get_sender(msg);
+
 	if (dbus_message_iter_init(msg, &iter) =3D=3D FALSE)
 		goto invalid_args;
 =

@@ -75,6 +101,19 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 			goto invalid_args;
 	}
 =

+	match.owner =3D (char *) sender;
+	match.path =3D (char *) path;
+	if (g_slist_find_custom(agents, &match, agent_cmp))
+		goto invalid_args;
+
+	agent =3D g_new0(struct agent, 1);
+	agent->owner =3D g_strdup(sender);
+	agent->path =3D g_strdup(path);
+	agent->codecs =3D g_memdup(codecs, length);
+	agent->codecs_len =3D length;
+
+	agents =3D g_slist_prepend(agents, agent);
+
 	return dbus_message_new_method_return(msg);
 =

 invalid_args:
-- =

1.7.11.7


--===============2691393960308602654==--

