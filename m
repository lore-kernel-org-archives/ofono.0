Content-Type: multipart/mixed; boundary="===============5679973063930229242=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 4/6] handsfree-audio: Set the voice setting for outgoing
 connections
Date: Thu, 15 Aug 2013 23:26:07 -0300
Message-ID: <1376619969-15080-5-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1376619969-15080-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5679973063930229242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the AG case, the voice setting needs to be set before we can
use Transparent SCO mode, which is necessary for Wideband speech
support.
---
 src/handsfree-audio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index c83086f..d550e6e 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -442,6 +442,7 @@ int ofono_handsfree_card_connect_sco(struct ofono_hands=
free_card *card)
 {
 	GIOChannel *io;
 	struct sockaddr_sco addr;
+	struct bt_voice voice;
 	int sk, ret;
 =

 	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
@@ -465,6 +466,13 @@ int ofono_handsfree_card_connect_sco(struct ofono_hand=
sfree_card *card)
 	addr.sco_family =3D AF_BLUETOOTH;
 	bt_str2ba(card->remote, &addr.sco_bdaddr);
 =

+	memset(&voice, 0, sizeof(voice));
+	voice.setting =3D codec2setting(card->selected_codec);
+
+	if (setsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice)) < 0)
+		ofono_error("Can't set voice settings: %s (%d)",
+						strerror(errno), errno);
+
 	ret =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
 	if (ret < 0 && errno !=3D EINPROGRESS) {
 		close(sk);
-- =

1.8.3.4


--===============5679973063930229242==--

