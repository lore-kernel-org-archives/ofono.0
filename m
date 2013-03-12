Content-Type: multipart/mixed; boundary="===============3940300697313741317=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 17/20] handsfree-audio: Use bitmask for supported codecs
Date: Tue, 12 Mar 2013 11:21:41 -0300
Message-ID: <1363098104-16467-18-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3940300697313741317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch changes the internal representation of the supported codecs.
Codecs are being declared in a sequentialily, represent the supported
codecs as bit-field helps to check for supported codecs and in some
cases it avoids dupplicated codec entries.
---
 src/handsfree-audio.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 0eb5c70..c0e644c 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -44,9 +44,11 @@
 #define HFP_AUDIO_CARD_INTERFACE	OFONO_SERVICE ".HandsfreeAudioCard"
 =

 /* Supported agent codecs */
+#define MAX_SUPPORTED_CODECS		2
 enum hfp_codec {
 	HFP_CODEC_CVSD =3D 0x01,
 	HFP_CODEC_MSBC =3D 0x02,
+	HFP_CODEC_LAST =3D HFP_CODEC_MSBC,
 };
 =

 struct ofono_handsfree_card {
@@ -63,8 +65,7 @@ struct ofono_handsfree_card {
 struct agent {
 	char *owner;
 	char *path;
-	unsigned char *codecs;
-	int codecs_len;
+	uint32_t codecs_bitmask;
 	guint watch;
 };
 =

@@ -74,6 +75,16 @@ static GSList *card_list =3D 0;
 static guint sco_watch =3D 0;
 static GSList *g_drivers =3D NULL;
 =

+static inline void set_bit(int nr, void *addr)
+{
+	*((uint32_t *) addr + (nr >> 5)) |=3D (1 << (nr & 31));
+}
+
+static inline int test_bit(int nr, void *addr)
+{
+	return *((uint32_t *) addr + (nr >> 5)) & (1 << (nr & 31));
+}
+
 static void send_new_connection(const char *card, int fd, uint8_t codec)
 {
 	DBusMessage *msg;
@@ -476,15 +487,20 @@ int ofono_handsfree_card_select_codec(struct ofono_ha=
ndsfree_card *card,
 =

 int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len)
 {
-	int len;
+	unsigned char codecs[MAX_SUPPORTED_CODECS];
+	int i, j, min;
 =

 	if (agent =3D=3D NULL)
 		return -EIO;
 =

-	len =3D MIN(buffer_len, agent->codecs_len);
-	memcpy(buffer, agent->codecs, len);
+	for (i =3D 0, j =3D 0; i <=3D HFP_CODEC_LAST; i++)
+		if (test_bit(i, &agent->codecs_bitmask))
+			codecs[j++] =3D i;
+
+	min =3D MIN(buffer_len, j);
+	memcpy(buffer, codecs, min);
 =

-	return len;
+	return min;
 }
 =

 static void agent_free(struct agent *agent)
@@ -494,7 +510,6 @@ static void agent_free(struct agent *agent)
 =

 	g_free(agent->owner);
 	g_free(agent->path);
-	g_free(agent->codecs);
 	g_free(agent);
 }
 =

@@ -572,7 +587,7 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 	unsigned char *codecs;
 	DBusMessageIter iter, array;
 	int length, i;
-	gboolean has_cvsd =3D FALSE;
+	uint32_t codecs_bitmask =3D 0;
 =

 	if (agent)
 		return __ofono_error_in_use(msg);
@@ -593,12 +608,14 @@ static DBusMessage *am_agent_register(DBusConnection =
*conn,
 =

 	for (i =3D 0; i < length; i++) {
 		if (codecs[i] =3D=3D HFP_CODEC_CVSD)
-			has_cvsd =3D TRUE;
-		else if (codecs[i] !=3D HFP_CODEC_MSBC)
+			set_bit(HFP_CODEC_CVSD, &codecs_bitmask);
+		else if (codecs[i] =3D=3D HFP_CODEC_MSBC)
+			set_bit(HFP_CODEC_MSBC, &codecs_bitmask);
+		else
 			return __ofono_error_invalid_args(msg);
 	}
 =

-	if (has_cvsd =3D=3D FALSE) {
+	if (!test_bit(HFP_CODEC_CVSD, &codecs_bitmask)) {
 		ofono_error("CVSD codec is mandatory");
 		return __ofono_error_invalid_args(msg);
 	}
@@ -606,8 +623,7 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 	agent =3D g_new0(struct agent, 1);
 	agent->owner =3D g_strdup(sender);
 	agent->path =3D g_strdup(path);
-	agent->codecs =3D g_memdup(codecs, length);
-	agent->codecs_len =3D length;
+	agent->codecs_bitmask =3D codecs_bitmask;
 	agent->watch =3D g_dbus_add_disconnect_watch(conn, sender,
 						agent_disconnect, NULL, NULL);
 =

-- =

1.7.11.7


--===============3940300697313741317==--

