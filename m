Content-Type: multipart/mixed; boundary="===============6810424136105616887=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 8/8] handsfree-audio: Enable wideband speech if defer is
 enabled
Date: Tue, 09 Apr 2013 17:45:43 -0300
Message-ID: <1365540343-8394-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1365540343-8394-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6810424136105616887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Only enable support for wideband speech codecs, at this point mSBC, if
the kernel support defer setup.
---
 src/handsfree-audio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index d55e6fc..cbaeb1f 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -66,6 +66,7 @@ static GSList *card_list =3D 0;
 static guint sco_watch =3D 0;
 static GSList *drivers =3D 0;
 static ofono_bool_t has_wideband =3D FALSE;
+static int defer_setup =3D 1;
 =

 static void send_new_connection(const char *card, int fd, uint8_t codec)
 {
@@ -159,7 +160,7 @@ static int sco_init(void)
 {
 	GIOChannel *sco_io;
 	struct sockaddr_sco saddr;
-	int sk, defer_setup =3D 1;
+	int sk;
 =

 	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
 								BTPROTO_SCO);
@@ -177,9 +178,11 @@ static int sco_init(void)
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
@@ -661,6 +664,9 @@ static DBusMessage *am_agent_register(DBusConnection *c=
onn,
 			has_cvsd =3D TRUE;
 		else if (codecs[i] !=3D HFP_CODEC_MSBC)
 			return __ofono_error_invalid_args(msg);
+
+		if (defer_setup)
+			has_wideband =3D TRUE;
 	}
 =

 	if (has_cvsd =3D=3D FALSE) {
-- =

1.8.2


--===============6810424136105616887==--

