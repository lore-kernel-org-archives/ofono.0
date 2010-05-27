Content-Type: multipart/mixed; boundary="===============3195541097468390996=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 05/11] Added message delivery time to dbus message.
Date: Thu, 27 May 2010 13:54:44 +0300
Message-ID: <1274957690-4893-5-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1274957690-4893-4-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3195541097468390996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

---
 src/sms.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 63e0190..b4a5364 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -579,8 +579,7 @@ static void dispatch_sms_delivery_report(struct ofono_s=
ms *sms,
 					OFONO_PROPERTIES_ARRAY_SIGNATURE,
 						&dict);
 =

-	/*This is the time when sender sent the message,
-	  should be delivery time?*/
+	/*This is the time when sender sent the message*/
 	ts =3D sms_scts_to_time(scts, &remote);
 	localtime_r(&ts, &local);
 =

@@ -592,6 +591,14 @@ static void dispatch_sms_delivery_report(struct ofono_=
sms *sms,
 	buf[127] =3D '\0';
 	ofono_dbus_dict_append(&dict, "SentTime", DBUS_TYPE_STRING, &str);
 =

+	/*This is the time when the message was delivered to the recipient*/
+	ts =3D sms_scts_to_time(dt, &remote);
+	localtime_r(&ts, &local);
+
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
+	buf[127] =3D '\0';
+	ofono_dbus_dict_append(&dict, "LocalDeliverTime", DBUS_TYPE_STRING, &str);
+
 	/*Status*/
 	if(*st=3D=3D0x00){
 		str =3D sms_address_to_string(raddr);
-- =

1.6.0.4


--===============3195541097468390996==--

