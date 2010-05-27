Content-Type: multipart/mixed; boundary="===============1727483185131795050=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 11/11] Style corrections.
Date: Thu, 27 May 2010 13:54:50 +0300
Message-ID: <1274957690-4893-11-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1274957690-4893-10-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1727483185131795050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

---
 src/sms.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index de2d367..6bca8cd 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -472,7 +472,8 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	if (valid_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset, ask_status_repo=
rt);
+	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset,
+						ask_status_report);
 =

 	if (!msg_list)
 		return __ofono_error_invalid_format(msg);
@@ -509,12 +510,12 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
 }
 =

 static GDBusMethodTable sms_manager_methods[] =3D {
-	{ "GetProperties",	"",	"a{sv}",	sms_get_properties,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SetProperty",	"sv",	"",		sms_set_property,
-							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendMessage",	"ssb",	"",		sms_send_message,
-							G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetProperties",	"",	"a{sv}", sms_get_properties,
+						 G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SetProperty",	"sv",	"",	 sms_set_property,
+						 G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SendMessage",	"ssb",	"",	 sms_send_message,
+						 G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 =

@@ -636,7 +637,7 @@ static void update_pending_status_report_mr_number(stru=
ct ofono_sms *sms,
 			  whole message is declared undelivered*/
 			if(current_mr->mr =3D=3D mr &&
 				status_report_state =3D=3D
-					SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED) {
+				SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED) {
 =

 				DBG("SMS-STATUS-REPORT: message %d not "\
 				"delivered", status_report_mr_numbers-> \
@@ -748,7 +749,8 @@ static void dispatch_sms_status_report(struct ofono_sms=
 *sms,
 =

 	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
 	buf[127] =3D '\0';
-	ofono_dbus_dict_append(&dict, "LocalDeliverTime", DBUS_TYPE_STRING, &str);
+	ofono_dbus_dict_append(&dict, "LocalDeliverTime",
+					DBUS_TYPE_STRING, &str);
 =

 	/*Status*/
 	if(*st=3D=3D0x00){
@@ -763,7 +765,7 @@ static void dispatch_sms_status_report(struct ofono_sms=
 *sms,
 		ofono_dbus_dict_append(&dict, "Message was not delivered to",
 							DBUS_TYPE_STRING, &str);
 		update_pending_status_report_mr_number(sms, mr,
-					SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED);
+				SMS_STATUS_REPORT_MESSAGE_NOT_DELIVERED);
 	}
 =

 	/*dbus-message assembled*/
@@ -927,7 +929,8 @@ static void handle_deliver(struct ofono_sms *sms, const=
 struct sms *incoming)
 	g_slist_free(l);
 }
 =

-static void handle_sms_status_report(struct ofono_sms *sms, const struct s=
ms *incoming)
+static void handle_sms_status_report(struct ofono_sms *sms,
+					const struct sms *incoming)
 {
 	GSList *l;
 =

-- =

1.6.0.4


--===============1727483185131795050==--

