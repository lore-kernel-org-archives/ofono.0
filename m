Content-Type: multipart/mixed; boundary="===============0783393184422066001=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH] Default to using 8bit reference numbers
Date: Thu, 02 Sep 2010 10:54:50 +0300
Message-ID: <1283414090-31727-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0783393184422066001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Just like the rest of the world is doing.
---
 src/sms.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 8262d0c..cdaa629 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -687,6 +687,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	struct ofono_modem *modem;
 	unsigned int flags;
 	unsigned int msg_id;
+	gboolean use_16bit_ref =3D FALSE;
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
 					DBUS_TYPE_STRING, &text,
@@ -696,7 +697,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	if (valid_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	msg_list =3D sms_text_prepare_with_alphabet(text, 0, TRUE,
+	msg_list =3D sms_text_prepare_with_alphabet(text, 0, use_16bit_ref,
 						&ref_offset,
 						sms->use_delivery_reports,
 						sms->alphabet);
@@ -704,7 +705,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	if (!msg_list)
 		return __ofono_error_invalid_format(msg);
 =

-	set_ref_and_to(msg_list, sms->ref, ref_offset, TRUE, to);
+	set_ref_and_to(msg_list, sms->ref, ref_offset, use_16bit_ref, to);
 	DBG("ref: %d, offset: %d", sms->ref, ref_offset);
 =

 	if (ref_offset !=3D 0) {
-- =

1.7.0.4


--===============0783393184422066001==--

