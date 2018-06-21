Content-Type: multipart/mixed; boundary="===============8893417209242584684=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: [PATCH 09/12] emulator: Use new voicecall enums
Date: Thu, 21 Jun 2018 20:20:58 +0300
Message-ID: <1529601661-4856-9-git-send-email-slava.monich@jolla.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8893417209242584684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/emulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/emulator.c b/src/emulator.c
index ccb26dc..bda8f35 100644
--- a/src/emulator.c
+++ b/src/emulator.c
@@ -404,9 +404,9 @@ static gboolean notify_ccwa(void *user_data)
 			!em->ccwa)
 		goto end;
 =

-	c =3D find_call_with_status(em, CALL_STATUS_WAITING);
+	c =3D find_call_with_status(em, OFONO_CALL_STATUS_WAITING);
 =

-	if (c && c->clip_validity =3D=3D CLIP_VALIDITY_VALID) {
+	if (c && c->clip_validity =3D=3D OFONO_CLIP_VALIDITY_VALID) {
 		phone =3D phone_number_to_string(&c->phone_number);
 		sprintf(str, "+CCWA: \"%s\",%d", phone, c->phone_number.type);
 =

@@ -439,19 +439,19 @@ static gboolean notify_ring(void *user_data)
 	if (!em->clip)
 		return TRUE;
 =

-	c =3D find_call_with_status(em, CALL_STATUS_INCOMING);
+	c =3D find_call_with_status(em, OFONO_CALL_STATUS_INCOMING);
 =

 	if (c =3D=3D NULL)
 		return TRUE;
 =

 	switch (c->clip_validity) {
-	case CLIP_VALIDITY_VALID:
+	case OFONO_CLIP_VALIDITY_VALID:
 		phone =3D phone_number_to_string(&c->phone_number);
 		sprintf(str, "+CLIP: \"%s\",%d", phone, c->phone_number.type);
 		g_at_server_send_unsolicited(em->server, str);
 		break;
 =

-	case CLIP_VALIDITY_WITHHELD:
+	case OFONO_CLIP_VALIDITY_WITHHELD:
 		g_at_server_send_unsolicited(em->server, "+CLIP: \"\",128");
 		break;
 	}
-- =

1.9.1


--===============8893417209242584684==--

