Content-Type: multipart/mixed; boundary="===============3975873715182888953=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [PATCH 3/7] handsfree-audio: Set the voice setting for outgoing
 connections
Date: Tue, 10 Sep 2013 21:09:42 -0300
Message-ID: <1378858186-683-3-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1378858186-683-1-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3975873715182888953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the AG case, the voice setting needs to be set before we can
use Transparent SCO mode, which is necessary for Wideband speech
support.
---
 src/handsfree-audio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
index 52d111a..5cfc939 100644
--- a/src/handsfree-audio.c
+++ b/src/handsfree-audio.c
@@ -478,6 +478,11 @@ int ofono_handsfree_card_connect_sco(struct ofono_hand=
sfree_card *card)
 	addr.sco_family =3D AF_BLUETOOTH;
 	bt_str2ba(card->remote, &addr.sco_bdaddr);
 =

+	if (apply_settings_from_codec(sk, card->selected_codec) =3D=3D FALSE) {
+		close(sk);
+		return -1;
+	}
+
 	ret =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
 	if (ret < 0 && errno !=3D EINPROGRESS) {
 		close(sk);
-- =

1.8.4


--===============3975873715182888953==--

