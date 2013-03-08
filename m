Content-Type: multipart/mixed; boundary="===============1285296868278829303=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v0 08/13] hfp_hf_bluez5: Add HFP 1.5 card connect callback
Date: Fri, 08 Mar 2013 20:11:20 -0300
Message-ID: <1362784285-22731-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1362784285-22731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1285296868278829303==
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
index 00159fa..bc91cfc 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -322,7 +322,36 @@ static void card_remove(struct ofono_handsfree_card *c=
ard)
 =

 static int card_audio_connect(const char *remote, const char *local)
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


--===============1285296868278829303==--

