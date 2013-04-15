Content-Type: multipart/mixed; boundary="===============5512183273199467968=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v3 5/6] handsfree-audio: Keep track whether defer_setup is
 enabled
Date: Mon, 15 Apr 2013 10:54:52 -0300
Message-ID: <1366034093-24084-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1366034093-24084-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5512183273199467968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

'defer_setup' will be one of the inputs when enabling or disabling
support for wideband speech codecs, we will only enable wideband
speech support if the kernel supports deferred setup.

So, we have to have this information available, in this case it means
a global variable.
---
 src/handsfree-audio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 7f5b33c..fc3d15b 100644
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
-- =

1.8.2


--===============5512183273199467968==--

