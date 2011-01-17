Content-Type: multipart/mixed; boundary="===============8330332867789285920=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [RFC PATCH 2/3] common: split valid_phone_number_format and adapt
 atoms
Date: Mon, 17 Jan 2011 11:59:27 -0300
Message-ID: <1295276368-32233-3-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1295276368-32233-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8330332867789285920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    4 ++++
 src/common.c          |   20 ++++++++++++++++++--
 src/common.h          |    2 ++
 src/message-waiting.c |   14 ++++++++++++++
 src/sim.c             |    2 +-
 src/sms.c             |    5 +++--
 6 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 512f223..9fdfeb5 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -260,6 +260,10 @@ static void sim_set_cf_indicator(struct ofono_call_for=
warding *cf)
 		data[0] =3D 0x01;
 =

 		if (cfu_voice) {
+			if (!valid_short_phone_number_format(
+						cond->phone_number.number))
+				return;
+
 			number_len =3D strlen(cond->phone_number.number);
 =

 			/* CFU indicator Status - Voice */
diff --git a/src/common.c b/src/common.c
index 4d93488..2096e79 100644
--- a/src/common.c
+++ b/src/common.c
@@ -234,7 +234,7 @@ struct error_entry ceer_errors[] =3D {
 	{ 127,	"Interworking, unspecified" },
 };
 =

-gboolean valid_phone_number_format(const char *number)
+gboolean valid_number_format(const char *number, int length)
 {
 	int len =3D strlen(number);
 	int begin =3D 0;
@@ -246,7 +246,7 @@ gboolean valid_phone_number_format(const char *number)
 	if (number[0] =3D=3D '+')
 		begin =3D 1;
 =

-	if ((len - begin) > OFONO_MAX_PHONE_NUMBER_LENGTH)
+	if ((len - begin) > length)
 		return FALSE;
 =

 	for (i =3D begin; i < len; i++) {
@@ -262,6 +262,22 @@ gboolean valid_phone_number_format(const char *number)
 	return TRUE;
 }
 =

+gboolean valid_phone_number_format(const char *number)
+{
+	return valid_number_format(number, OFONO_MAX_PHONE_NUMBER_LENGTH);
+}
+
+/*
+ * According to 3GPP TS 24.011 or 3GPP TS 31.102, some
+ * addresses (or numbers), like Service Centre address,
+ * Destination address, or EFADN (Abbreviated dialling numbers),
+ * are up 20 digits.
+ */
+gboolean valid_short_phone_number_format(const char *number)
+{
+	return valid_number_format(number, 20);
+}
+
 gboolean valid_cdma_phone_number_format(const char *number)
 {
 	int len =3D strlen(number);
diff --git a/src/common.h b/src/common.h
index 64f297e..86f97f8 100644
--- a/src/common.h
+++ b/src/common.h
@@ -131,7 +131,9 @@ enum pin_type {
 =

 const char *telephony_error_to_str(const struct ofono_error *error);
 =

+gboolean valid_number_format(const char *number, int length);
 gboolean valid_phone_number_format(const char *number);
+gboolean valid_short_phone_number_format(const char *number);
 const char *phone_number_to_string(const struct ofono_phone_number *ph);
 void string_to_phone_number(const char *str, struct ofono_phone_number *ph=
);
 =

diff --git a/src/message-waiting.c b/src/message-waiting.c
index d8bfe34..5322f96 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -192,6 +192,13 @@ static DBusMessage *set_cphs_mbdn(struct ofono_message=
_waiting *mw,
 		return NULL;
 	}
 =

+	if (!valid_short_phone_number_format(number)) {
+		if (msg)
+			return __ofono_error_invalid_format(msg);
+
+		return NULL;
+	}
+
 	req =3D g_new0(struct mbdn_set_request, 1);
 =

 	req->mw =3D mw;
@@ -291,6 +298,13 @@ static DBusMessage *set_mbdn(struct ofono_message_wait=
ing *mw, int mailbox,
 		return NULL;
 	}
 =

+	if (!valid_short_phone_number_format(number)) {
+		if (msg)
+			return __ofono_error_invalid_format(msg);
+
+		return NULL;
+	}
+
 	req =3D g_new0(struct mbdn_set_request, 1);
 =

 	req->mw =3D mw;
diff --git a/src/sim.c b/src/sim.c
index d627647..6b3a911 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -565,7 +565,7 @@ static DBusMessage *sim_set_property(DBusConnection *co=
nn, DBusMessage *msg,
 =

 			dbus_message_iter_get_basic(&var_elem, &value);
 =

-			if (!valid_phone_number_format(value))
+			if (!valid_short_phone_number_format(value))
 				goto error;
 =

 			own =3D g_new0(struct ofono_phone_number, 1);
diff --git a/src/sms.c b/src/sms.c
index 9bb5c93..a6134bd 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -654,7 +654,8 @@ static DBusMessage *sms_set_property(DBusConnection *co=
nn, DBusMessage *msg,
 =

 		dbus_message_iter_get_basic(&var, &value);
 =

-		if (strlen(value) =3D=3D 0 || !valid_phone_number_format(value))
+		if (strlen(value) =3D=3D 0 ||
+				!valid_short_phone_number_format(value))
 			return __ofono_error_invalid_format(msg);
 =

 		if (sms->driver->sca_set =3D=3D NULL ||
@@ -983,7 +984,7 @@ static DBusMessage *sms_send_message(DBusConnection *co=
nn, DBusMessage *msg,
 					DBUS_TYPE_INVALID))
 		return __ofono_error_invalid_args(msg);
 =

-	if (valid_phone_number_format(to) =3D=3D FALSE)
+	if (valid_short_phone_number_format(to) =3D=3D FALSE)
 		return __ofono_error_invalid_format(msg);
 =

 	msg_list =3D sms_text_prepare(to, text, sms->ref, use_16bit_ref,
-- =

1.7.2.3


--===============8330332867789285920==--

