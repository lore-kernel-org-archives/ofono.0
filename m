Content-Type: multipart/mixed; boundary="===============3955424831083083120=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 18/20] handsfree-audio: Disable mSBC if defer is off
Date: Tue, 12 Mar 2013 11:21:42 -0300
Message-ID: <1363098104-16467-19-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363098104-16467-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3955424831083083120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the kernel doesn't support defer setup, this patch disables the mSBC
codec support removing it from the supported codecs bitmask.
---
 src/handsfree-audio.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index c0e644c..b644b0b 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -74,6 +74,7 @@ static int ref_count =3D 0;
 static GSList *card_list =3D 0;
 static guint sco_watch =3D 0;
 static GSList *g_drivers =3D NULL;
+static int defer_setup =3D 1;
 =

 static inline void set_bit(int nr, void *addr)
 {
@@ -85,6 +86,11 @@ static inline int test_bit(int nr, void *addr)
 	return *((uint32_t *) addr + (nr >> 5)) & (1 << (nr & 31));
 }
 =

+static inline void clear_bit(int nr, void *addr)
+{
+	*((uint32_t *) addr + (nr >> 5)) &=3D ~(1 << (nr & 31));
+}
+
 static void send_new_connection(const char *card, int fd, uint8_t codec)
 {
 	DBusMessage *msg;
@@ -184,7 +190,7 @@ static int sco_init(void)
 {
 	GIOChannel *sco_io;
 	struct sockaddr_sco saddr;
-	int sk, defer_setup =3D 1;
+	int sk;
 =

 	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
 								BTPROTO_SCO);
@@ -202,9 +208,11 @@ static int sco_init(void)
 	}
 =

 	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
-				&defer_setup, sizeof(defer_setup)) < 0)
+				&defer_setup, sizeof(defer_setup)) < 0) {
+		defer_setup =3D 0;
 		ofono_warn("Can't enable deferred setup: %s (%d)",
 						strerror(errno), errno);
+	}
 =

 	if (listen(sk, 5) < 0) {
 		close(sk);
@@ -620,6 +628,10 @@ static DBusMessage *am_agent_register(DBusConnection *=
conn,
 		return __ofono_error_invalid_args(msg);
 	}
 =

+	/* Disable mSBC if defer setup is not supported */
+	if (defer_setup =3D=3D 0 && test_bit(HFP_CODEC_MSBC, &codecs_bitmask))
+		clear_bit(HFP_CODEC_MSBC, &codecs_bitmask);
+
 	agent =3D g_new0(struct agent, 1);
 	agent->owner =3D g_strdup(sender);
 	agent->path =3D g_strdup(path);
-- =

1.7.11.7


--===============3955424831083083120==--

