Content-Type: multipart/mixed; boundary="===============4998779066118127714=="
MIME-Version: 1.0
From: Pasi Miettinen <pasi.miettinen@ixonos.com>
Subject: [RFC PATCH 3/6] Support for basic SMS Status Report.
Date: Fri, 04 Jun 2010 14:17:34 +0300
Message-ID: <1275650257-30593-4-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1275650257-30593-3-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4998779066118127714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 109 insertions(+), 1 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 618e035..14748c6 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -553,6 +553,75 @@ static void dispatch_text_message(struct ofono_sms *sm=
s,
 	}
 }
 =

+static void dispatch_sms_delivery_report(struct ofono_sms *sms,
+					const enum sms_st *st,
+					const struct sms_address *raddr,
+					const struct sms_scts *scts,
+					const struct sms_scts *dt)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	const char *path =3D __ofono_atom_get_path(sms->atom);
+	DBusMessage *signal;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	char buf[128];
+	time_t ts;
+	struct tm remote;
+	struct tm local;
+	const char *str =3D buf;
+
+	if (!st) {
+		DBG("status unavailable");
+		return;
+	}
+
+	signal =3D dbus_message_new_signal(path, OFONO_SMS_MANAGER_INTERFACE,
+						"IncomingStatusReport");
+
+	if (!signal)
+		return;
+
+	/*Start assembling dbus-message*/
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					OFONO_PROPERTIES_ARRAY_SIGNATURE,
+						&dict);
+
+	/*This is the time when sender sent the message*/
+	ts =3D sms_scts_to_time(scts, &remote);
+	localtime_r(&ts, &local);
+
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
+	buf[127] =3D '\0';
+	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING, &str);
+
+	/*This is the time when the message was delivered to the recipient*/
+	ts =3D sms_scts_to_time(dt, &remote);
+	localtime_r(&ts, &local);
+
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &local);
+	buf[127] =3D '\0';
+	ofono_dbus_dict_append(&dict, "LocalDeliverTime",
+					DBUS_TYPE_STRING, &str);
+
+	/*Status*/
+	if (*st =3D=3D 0x00) {
+		str =3D sms_address_to_string(raddr);
+		ofono_dbus_dict_append(&dict, "delivered",
+					DBUS_TYPE_STRING, &str);
+	} else {
+		str =3D sms_address_to_string(raddr);
+		ofono_dbus_dict_append(&dict, "undeliverable",
+					DBUS_TYPE_STRING, &str);
+	}
+
+	/*dbus-message assembled*/
+	dbus_message_iter_close_container(&iter, &dict);
+
+	g_dbus_send_message(conn, signal);
+}
+
 static void sms_dispatch(struct ofono_sms *sms, GSList *sms_list)
 {
 	GSList *l;
@@ -660,6 +729,17 @@ static void sms_dispatch(struct ofono_sms *sms, GSList=
 *sms_list)
 	}
 }
 =

+static void sms_status_report_dispatch(struct ofono_sms *sms, GSList *sms_=
list)
+{
+	const struct sms *s;
+
+	s =3D sms_list->data;
+	dispatch_sms_delivery_report(sms, &s->status_report.st,
+					&s->status_report.raddr,
+					&s->status_report.scts,
+					&s->status_report.dt);
+}
+
 static void handle_deliver(struct ofono_sms *sms, const struct sms *incomi=
ng)
 {
 	GSList *l;
@@ -693,6 +773,16 @@ static void handle_deliver(struct ofono_sms *sms, cons=
t struct sms *incoming)
 	g_slist_free(l);
 }
 =

+static void handle_sms_status_report(struct ofono_sms *sms,
+						const struct sms *incoming)
+{
+	GSList *l;
+
+	l =3D g_slist_append(NULL, (void *)incoming);
+	sms_status_report_dispatch(sms, l);
+	g_slist_free(l);
+}
+
 static inline gboolean handle_mwi(struct ofono_sms *sms, struct sms *s)
 {
 	gboolean discard;
@@ -824,7 +914,25 @@ out:
 void ofono_sms_status_notify(struct ofono_sms *sms, unsigned char *pdu,
 				int len, int tpdu_len)
 {
-	ofono_error("SMS Status-Report not yet handled");
+	struct sms s;
+	enum sms_class cls;
+
+	if (!sms_decode(pdu, len, FALSE, tpdu_len, &s)) {
+		ofono_error("Unable to decode PDU");
+		return;
+	}
+
+	if (s.type !=3D SMS_TYPE_STATUS_REPORT) {
+		ofono_error("Expecting a STATUS REPORT pdu");
+		return;
+	}
+
+	if (!sms_dcs_decode(s.deliver.dcs, &cls, NULL, NULL, NULL)) {
+		ofono_error("Unknown / Reserved DCS.  Ignoring");
+		return;
+	}
+
+	handle_sms_status_report(sms, &s);
 }
 =

 int ofono_sms_driver_register(const struct ofono_sms_driver *d)
-- =

1.6.0.4



--===============4998779066118127714==--

