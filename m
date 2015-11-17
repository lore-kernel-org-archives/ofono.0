Content-Type: multipart/mixed; boundary="===============0563343835851085811=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: [PATCH] emulator: fail when SCO connection setup fails
Date: Tue, 17 Nov 2015 17:05:22 +0100
Message-ID: <1447776322-9535-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0563343835851085811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/emulator.c b/src/emulator.c
index 4c81a39..0a5c67e 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -1683,6 +1683,7 @@ int ofono_emulator_start_codec_negotiation(struct ofo=
no_emulator *em,
 {
 	char buf[64];
 	unsigned char codec;
+	int err;
 =

 	if (em =3D=3D NULL)
 		return -EINVAL;
@@ -1707,7 +1708,11 @@ int ofono_emulator_start_codec_negotiation(struct of=
ono_emulator *em,
 		 * already have a negotiated codec we can proceed here
 		 * without doing any negotiation again.
 		 */
-		ofono_handsfree_card_connect_sco(em->card);
+		err =3D ofono_handsfree_card_connect_sco(em->card);
+		if (err < 0) {
+			ofono_error("SCO connection failed");
+			return err;
+		}
 =

 		return 0;
 	}
-- =

2.5.0


--===============0563343835851085811==--

