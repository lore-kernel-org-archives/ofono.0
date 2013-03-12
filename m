Content-Type: multipart/mixed; boundary="===============0860634879802002325=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 08/15] hfp_hf_bluez5: Add HFP 1.5 connect implementation
Date: Tue, 12 Mar 2013 09:42:06 -0300
Message-ID: <1363092133-1092-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1363092133-1092-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0860634879802002325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds the Audio Card driver connect callback implementation
to handle SCO connection requested by the driver. This approach
addresses devices compliant with HFP 1.5
---
 plugins/hfp_hf_bluez5.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 1b3b7bc..f1c3027 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -322,7 +322,36 @@ static void card_remove(struct ofono_handsfree_card *c=
ard)
 =

 static int card_audio_connect15(const char *remote, const char *local)
 {
-	return 0;
+	struct sockaddr_sco addr;
+	int sk, ret;
+
+	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
+								BTPROTO_SCO);
+	if (sk < 0)
+		return -1;
+
+	/* Bind to local address */
+	memset(&addr, 0, sizeof(addr));
+	addr.sco_family =3D AF_BLUETOOTH;
+	bt_str2ba(local, &addr.sco_bdaddr);
+
+	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		close(sk);
+		return -1;
+	}
+
+	/* Connect to remote device */
+	memset(&addr, 0, sizeof(addr));
+	addr.sco_family =3D AF_BLUETOOTH;
+	bt_str2ba(remote, &addr.sco_bdaddr);
+
+	ret =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+	if (ret < 0 && !(errno =3D=3D EAGAIN || errno =3D=3D EINPROGRESS)) {
+		close(sk);
+		return -1;
+	}
+
+	return sk;
 }
 =

 static struct ofono_handsfree_card_driver card_driver15 =3D {
-- =

1.7.11.7


--===============0860634879802002325==--

