Content-Type: multipart/mixed; boundary="===============1172730968218334553=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [RFC 6/6] sms: Use main configuration for 16bit ref number
Date: Wed, 26 Jan 2011 10:56:26 +0200
Message-ID: <1296032186-21497-7-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296032186-21497-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1172730968218334553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 7224bdf..48d2d81 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -842,7 +842,6 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	GSList *msg_list;
 	struct ofono_modem *modem;
 	unsigned int flags;
-	gboolean use_16bit_ref =3D FALSE;
 	int err;
 	struct ofono_uuid uuid;
 =

@@ -854,7 +853,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	if (valid_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	msg_list =3D sms_text_prepare(to, text, sms->ref, use_16bit_ref,
+	msg_list =3D sms_text_prepare(to, text, sms->ref, main_opts.use_16bit_ref,
 						sms->use_delivery_reports);
 =

 	if (msg_list =3D=3D NULL)
-- =

1.7.1


--===============1172730968218334553==--

