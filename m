Content-Type: multipart/mixed; boundary="===============7327816240836417841=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 08/11] Some style corrections.
Date: Thu, 27 May 2010 13:54:47 +0300
Message-ID: <1274957690-4893-8-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1274957690-4893-7-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7327816240836417841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

---
 src/sms.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index d079ece..2d9088b 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -542,7 +542,7 @@ static void dispatch_text_message(struct ofono_sms *sms,
 	}
 }
 =

-static void dispatch_sms_delivery_report(struct ofono_sms *sms,
+static void dispatch_sms_status_report(struct ofono_sms *sms,
 					const enum sms_st *st,
 					const struct sms_address *raddr,
 					const struct sms_scts *scts,
@@ -604,11 +604,13 @@ static void dispatch_sms_delivery_report(struct ofono=
_sms *sms,
 	/*Status*/
 	if(*st=3D=3D0x00){
 		str =3D sms_address_to_string(raddr);
-		ofono_dbus_dict_append(&dict, "Message was delivered to", DBUS_TYPE_STRI=
NG, &str);
+		ofono_dbus_dict_append(&dict, "Message was delivered to",
+							DBUS_TYPE_STRING, &str);
 	}
 	else{
 		str =3D sms_address_to_string(raddr);
-		ofono_dbus_dict_append(&dict, "Message was not delivered to", DBUS_TYPE_=
STRING, &str);
+		ofono_dbus_dict_append(&dict, "Message was not delivered to",
+							DBUS_TYPE_STRING, &str);
 	}
 =

 	/*dbus-message assembled*/
@@ -731,7 +733,7 @@ static void sms_status_report_dispatch(struct ofono_sms=
 *sms, GSList *sms_list)
 	enum sms_charset uninitialized_var(old_charset);
 =

 	s =3D sms_list->data;
-	dispatch_sms_delivery_report(sms, &s->status_report.st,
+	dispatch_sms_status_report(sms, &s->status_report.st,
 					&s->status_report.raddr,
 					&s->status_report.scts,
 					&s->status_report.dt);
@@ -775,10 +777,6 @@ static void handle_sms_status_report(struct ofono_sms =
*sms, const struct sms *in
 {
 	GSList *l;
 =

-	/*TODO:
-	fragmented SMS delivery report? check handle_deliver()
-	*/
-
 	l =3D g_slist_append(NULL, (void *)incoming);
 	sms_status_report_dispatch(sms, l);
 	g_slist_free(l);
@@ -801,7 +799,7 @@ void ofono_sms_deliver_notify(struct ofono_sms *sms, un=
signed char *pdu,
 {
 	struct sms s;
 	enum sms_class cls;
-	DBG("ofono_sms_deliver_notify");
+
 	if (!sms_decode(pdu, len, FALSE, tpdu_len, &s)) {
 		ofono_error("Unable to decode PDU");
 		return;
-- =

1.6.0.4


--===============7327816240836417841==--

