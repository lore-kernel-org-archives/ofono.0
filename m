Content-Type: multipart/mixed; boundary="===============1524143609865140735=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCHv2] Fix adding 8bit reference number
Date: Thu, 02 Sep 2010 10:47:43 +0300
Message-ID: <1283413663-30349-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1524143609865140735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 7298563..2012fe5 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -522,7 +522,7 @@ static gboolean tx_next(gpointer user_data)
 }
 =

 static void set_ref_and_to(GSList *msg_list, guint16 ref, int offset,
-				const char *to)
+				gboolean use_16bit, const char *to)
 {
 	GSList *l;
 	struct sms *sms;
@@ -530,12 +530,17 @@ static void set_ref_and_to(GSList *msg_list, guint16 =
ref, int offset,
 	for (l =3D msg_list; l; l =3D l->next) {
 		sms =3D l->data;
 =

-		if (offset !=3D 0) {
-			sms->submit.ud[offset] =3D (ref & 0xf0) >> 8;
-			sms->submit.ud[offset+1] =3D (ref & 0x0f);
-		}
-
 		sms_address_from_string(&sms->submit.daddr, to);
+
+		if (offset =3D=3D 0)
+			continue;
+
+		if (use_16bit) {
+			sms->submit.ud[offset] =3D ref & 0xf0 >> 8;
+			sms->submit.ud[offset+1] =3D ref & 0x0f;
+		} else {
+			sms->submit.ud[offset] =3D ref & 0x0f;
+		}
 	}
 }
 =

@@ -621,7 +626,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	if (!msg_list)
 		return __ofono_error_invalid_format(msg);
 =

-	set_ref_and_to(msg_list, sms->ref, ref_offset, to);
+	set_ref_and_to(msg_list, sms->ref, ref_offset, TRUE, to);
 	DBG("ref: %d, offset: %d", sms->ref, ref_offset);
 =

 	if (ref_offset !=3D 0) {
-- =

1.7.0.4


--===============1524143609865140735==--

