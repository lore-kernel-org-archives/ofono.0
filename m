Content-Type: multipart/mixed; boundary="===============9170701582846499629=="
MIME-Version: 1.0
From: pasi.miettinen@ixonos.com
Subject: [PATCH 06/11] Made it possible to ask for status report via
 SendMessage method parameters. True=status report on, false=off.
Date: Thu, 27 May 2010 13:54:45 +0300
Message-ID: <1274957690-4893-6-git-send-email-pasi.miettinen@ixonos.com>
In-Reply-To: <1274957690-4893-5-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9170701582846499629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pasi Miettinen <pasi.miettinen@ixonos.com>

Also made some repairs for dispatch_sms_delivery_report() and
sms_status_report_dispatch() to survive the make :)
---
 src/sms.c       |   13 ++++++++-----
 src/smsutil.c   |    5 +++--
 src/smsutil.h   |    3 ++-
 unit/test-sms.c |   10 +++++-----
 4 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index b4a5364..d079ece 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -400,6 +400,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 	struct ofono_sms *sms =3D data;
 	const char *to;
 	const char *text;
+	gboolean ask_status_report;
 	GSList *msg_list;
 	int ref_offset;
 	struct tx_queue_entry *entry;
@@ -407,13 +408,14 @@ static DBusMessage *sms_send_message(DBusConnection *=
conn, DBusMessage *msg,
 =

 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &to,
 					DBUS_TYPE_STRING, &text,
+					DBUS_TYPE_BOOLEAN, &ask_status_report,
 					DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 =

 	if (valid_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

-	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset);
+	msg_list =3D sms_text_prepare(text, 0, TRUE, &ref_offset, ask_status_repo=
rt);
 =

 	if (!msg_list)
 		return __ofono_error_invalid_format(msg);
@@ -453,7 +455,7 @@ static GDBusMethodTable sms_manager_methods[] =3D {
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ "SetProperty",	"sv",	"",		sms_set_property,
 							G_DBUS_METHOD_FLAG_ASYNC },
-	{ "SendMessage",	"ss",	"",		sms_send_message,
+	{ "SendMessage",	"ssb",	"",		sms_send_message,
 							G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
@@ -472,7 +474,6 @@ static void dispatch_app_datagram(struct ofono_sms *sms=
, int dst, int src,
 	DBG("Got app datagram for dst port: %d, src port: %d",
 			dst, src);
 	DBG("Contents-Len: %ld", len);
-	//DBG("buf: %s", buf);
 }
 =

 static void dispatch_text_message(struct ofono_sms *sms,
@@ -544,7 +545,8 @@ static void dispatch_text_message(struct ofono_sms *sms,
 static void dispatch_sms_delivery_report(struct ofono_sms *sms,
 					const enum sms_st *st,
 					const struct sms_address *raddr,
-					const struct sms_scts *scts)
+					const struct sms_scts *scts,
+					const struct sms_scts *dt)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	const char *path =3D __ofono_atom_get_path(sms->atom);
@@ -731,7 +733,8 @@ static void sms_status_report_dispatch(struct ofono_sms=
 *sms, GSList *sms_list)
 	s =3D sms_list->data;
 	dispatch_sms_delivery_report(sms, &s->status_report.st,
 					&s->status_report.raddr,
-					&s->status_report.scts);
+					&s->status_report.scts,
+					&s->status_report.dt);
 =

 }
 =

diff --git a/src/smsutil.c b/src/smsutil.c
index 2679cc2..b627458 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2580,7 +2580,8 @@ static inline GSList *sms_list_append(GSList *l, cons=
t struct sms *in)
  * if no concatenation took place.
  */
 GSList *sms_text_prepare(const char *utf8, guint16 ref,
-				gboolean use_16bit, int *ref_offset)
+				gboolean use_16bit, int *ref_offset,
+				const gboolean ask_status_report)
 {
 	struct sms template;
 	int offset =3D 0;
@@ -2596,7 +2597,7 @@ GSList *sms_text_prepare(const char *utf8, guint16 re=
f,
 	template.submit.rd =3D FALSE;
 	template.submit.vpf =3D SMS_VALIDITY_PERIOD_FORMAT_RELATIVE;
 	template.submit.rp =3D FALSE;
-	template.submit.srr =3D TRUE;
+	template.submit.srr =3D ask_status_report;
 	template.submit.mr =3D 0;
 	template.submit.vp.relative =3D 0xA7; /* 24 Hours */
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index a060c1b..d55b83a 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -479,7 +479,8 @@ GSList *sms_assembly_add_fragment(struct sms_assembly *=
assembly,
 void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
 =

 GSList *sms_text_prepare(const char *utf8, guint16 ref,
-				gboolean use_16bit, int *ref_offset);
+				gboolean use_16bit, int *ref_offset,
+				const gboolean ask_status_report);
 =

 gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, enum sms_class *cls,
 			enum sms_charset *charset, gboolean *compressed,
diff --git a/unit/test-sms.c b/unit/test-sms.c
index b242913..5a1daa1 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -685,7 +685,7 @@ static void test_assembly()
 	if (g_test_verbose())
 		g_printf("Text:\n%s\n", utf8);
 =

-	l =3D sms_text_prepare(utf8, ref, TRUE, NULL);
+	l =3D sms_text_prepare(utf8, ref, TRUE, NULL, FALSE);
 	g_assert(l);
 	g_assert(g_slist_length(l) =3D=3D 3);
 =

@@ -715,7 +715,7 @@ static void test_prepare_7bit()
 	int encoded_tpdu_len;
 	char *encoded_pdu;
 =

-	r =3D sms_text_prepare(test_no_fragmentation_7bit, 0, FALSE, NULL);
+	r =3D sms_text_prepare(test_no_fragmentation_7bit, 0, FALSE, NULL, FALSE);
 =

 	g_assert(r !=3D NULL);
 =

@@ -788,7 +788,7 @@ static void test_prepare_concat()
 	if (g_test_verbose())
 		g_print("strlen: %zd\n", strlen(pad1));
 =

-	r =3D sms_text_prepare(pad1, 0, TRUE, NULL);
+	r =3D sms_text_prepare(pad1, 0, TRUE, NULL, FALSE);
 =

 	g_assert(r);
 	g_assert(g_slist_length(r) =3D=3D 2);
@@ -865,7 +865,7 @@ static void test_limit(gunichar uni, int target_size, g=
boolean use_16bit)
 =

 	utf8[i] =3D '\0';
 =

-	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL);
+	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL, FALSE);
 =

 	g_assert(l);
 	g_assert(g_slist_length(l) =3D=3D 255);
@@ -878,7 +878,7 @@ static void test_limit(gunichar uni, int target_size, g=
boolean use_16bit)
 	memcpy(utf8 + i, utf8_char, stride);
 	utf8[i+stride] =3D '\0';
 =

-	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL);
+	l =3D sms_text_prepare(utf8, 0, use_16bit, NULL, FALSE);
 =

 	g_assert(l =3D=3D NULL);
 	g_free(utf8);
-- =

1.6.0.4


--===============9170701582846499629==--

