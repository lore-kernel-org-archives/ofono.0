Content-Type: multipart/mixed; boundary="===============8251871923993923575=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH] emulator: fix +CLIP in case of withheld call
Date: Wed, 20 Apr 2011 22:24:41 +0200
Message-ID: <1303331081-5047-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8251871923993923575==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index 9b4647b..9055909 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -261,11 +261,19 @@ static void notify_ring(struct ofono_emulator *em)
 =

 	c =3D find_call_with_status(em, CALL_STATUS_INCOMING);
 =

-	if (c && c->clip_validity =3D=3D CLIP_VALIDITY_VALID) {
+	if (c =3D=3D NULL)
+		return;
+
+	switch (c->clip_validity) {
+	case CLIP_VALIDITY_VALID:
 		phone =3D phone_number_to_string(&c->phone_number);
 		sprintf(str, "+CLIP: \"%s\",%d", phone, c->phone_number.type);
-
 		g_at_server_send_unsolicited(em->server, str);
+		break;
+
+	case CLIP_VALIDITY_WITHHELD:
+		g_at_server_send_unsolicited(em->server, "+CLIP: \"\",128");
+		break;
 	}
 }
 =

-- =

1.7.1


--===============8251871923993923575==--

