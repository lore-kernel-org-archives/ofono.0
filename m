Content-Type: multipart/mixed; boundary="===============8562366000391032564=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Implement writing EF-MBDN on SetProperty or Enhanced
 Voicemail IE.
Date: Wed, 05 Aug 2009 09:08:40 +0200
Message-ID: <1249456120-10263-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8562366000391032564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I've not tested this on a real SIM yet.
---
 src/message-waiting.c |   51 ++++++++++++++++++++++++++++++++++++---------=
---
 src/simutil.c         |   27 +++++++++++++++++++++++++
 src/simutil.h         |    2 +
 src/smsutil.c         |   47 +++++++++++++++++++++++++++++---------------
 src/smsutil.h         |    8 +++++++
 5 files changed, 106 insertions(+), 29 deletions(-)

diff --git a/src/message-waiting.c b/src/message-waiting.c
index 14a6e9c..568cea6 100644
--- a/src/message-waiting.c
+++ b/src/message-waiting.c
@@ -164,12 +164,12 @@ static DBusMessage *mw_get_properties(DBusConnection =
*conn,
 	return reply;
 }
 =

-static void mbdn_set_cb(gboolean ok, void *data)
+static void mbdn_set_cb(struct ofono_modem *modem, int ok, void *data)
 {
 	struct mbdn_set_request *req =3D data;
 	struct ofono_phone_number *old =3D &req->mw->mailbox_number[req->mailbox];
 	const char *property;
-	DBusMessage *reply;
+	DBusMessage *reply =3D 0; /* Quiet a warning */
 =

 	if (!ok) {
 		if (req->msg)
@@ -208,11 +208,19 @@ out:
 	g_free(req);
 }
 =

-static void set_mbdn(struct ofono_modem *modem, int mailbox,
+static DBusMessage *set_mbdn(struct ofono_modem *modem, int mailbox,
 			const char *number, DBusMessage *msg)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	struct mbdn_set_request *req;
+	unsigned char efmbdn[255];
+
+	if (modem->message_waiting->efmbdn_record_id[mailbox] =3D=3D 0) {
+		if (msg)
+			return __ofono_error_failed(msg);
+
+		return NULL;
+	}
 =

 	req =3D g_new0(struct mbdn_set_request, 1);
 =

@@ -222,8 +230,19 @@ static void set_mbdn(struct ofono_modem *modem, int ma=
ilbox,
 	string_to_phone_number(number, &req->number);
 	req->msg =3D dbus_message_ref(msg);
 =

-	/* TODO: Fill the actual sim_write data */
-	mbdn_set_cb(TRUE, req);
+	sim_adn_build(efmbdn, req->mw->efmbdn_length, &req->number);
+
+	if (ofono_sim_write(modem, SIM_EFMBDN_FILEID, mbdn_set_cb,
+			OFONO_SIM_FILE_STRUCTURE_FIXED,
+			req->mw->efmbdn_record_id[mailbox],
+			efmbdn, req->mw->efmbdn_length, req) =3D=3D -1) {
+		g_free(req);
+
+		if (msg)
+			return __ofono_error_failed(msg);
+	}
+
+	return NULL;
 }
 =

 static DBusMessage *mw_set_property(DBusConnection *conn, DBusMessage *msg,
@@ -275,8 +294,7 @@ static DBusMessage *mw_set_property(DBusConnection *con=
n, DBusMessage *msg,
 		if (g_str_equal(cur_number, value))
 			return dbus_message_new_method_return(msg);
 =

-		set_mbdn(modem, i, value, msg);
-		return NULL;
+		return set_mbdn(modem, i, value, msg);
 	}
 =

 	return __ofono_error_invalid_args(msg);
@@ -599,6 +617,7 @@ static void handle_enhanced_voicemail_iei(struct ofono_=
modem *modem,
 {
 	int profile, n;
 	gboolean set;
+	struct sms_address mailbox_address;
 =

 	if (length < 3)
 		return;
@@ -614,9 +633,10 @@ static void handle_enhanced_voicemail_iei(struct ofono=
_modem *modem,
 		if (discard)
 			*discard =3D (iei[0] & (1 << 4)) ? FALSE : TRUE;
 =

-		/* TODO: VM_MAILBOX_ACCESS_ADDRESS */
-		n =3D 2 + (iei[1] + 1) / 2;
-		if (length < n + 11)
+		/* VM_MAILBOX_ACCESS_ADDRESS */
+		n =3D 0;
+		if (!sms_decode_address_field(iei + 1, length - 1, &n,
+					FALSE, &mailbox_address))
 			return;
 =

 		/* TODO: VM_MESSAGE_PRIORITY_INDICATION */
@@ -636,9 +656,10 @@ static void handle_enhanced_voicemail_iei(struct ofono=
_modem *modem,
 		if (discard)
 			*discard =3D (iei[0] & (1 << 4)) ? FALSE : TRUE;
 =

-		/* TODO: VM_MAILBOX_ACCESS_ADDRESS */
-		n =3D 2 + (iei[1] + 1) / 2;
-		if (length < n + 11)
+		/* VM_MAILBOX_ACCESS_ADDRESS */
+		n =3D 0;
+		if (!sms_decode_address_field(iei + 1, length - 1, &n,
+					FALSE, &mailbox_address))
 			return;
 =

 		/* Other parameters currently not supported */
@@ -647,6 +668,10 @@ static void handle_enhanced_voicemail_iei(struct ofono=
_modem *modem,
 		mw_set_indicator(modem, profile, SMS_MWI_TYPE_VOICE,
 					set, iei[n + 2]);
 	}
+
+	if (mailbox_address.address[0] !=3D '\0')
+		set_mbdn(modem, SMS_MWI_TYPE_VOICE,
+				sms_address_to_string(&mailbox_address), NULL);
 }
 =

 void ofono_handle_sms_mwi(struct ofono_modem *modem,
diff --git a/src/simutil.c b/src/simutil.c
index 51b1f5c..7a0830e 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -426,3 +426,30 @@ gboolean sim_adn_parse(const unsigned char *data, int =
length,
 =

 	return TRUE;
 }
+
+void sim_adn_build(unsigned char *data, int length,
+			const struct ofono_phone_number *ph)
+{
+	int number_len =3D strlen(ph->number);
+
+	/* Alpha-Identifier field */
+	if (length > 14) {
+		memset(data, 0xff, length - 14);
+		data +=3D length - 14;
+	}
+
+	number_len =3D (number_len + 1) / 2;
+	*data++ =3D number_len + 1;
+
+	/* Use given number type and 'Unknown' for Numbering Plan */
+	*data++ =3D 0x80 | (ph->type << 4) | 0;
+
+	encode_bcd_number(ph->number, data);
+	memset(data + number_len, 0xff, 10 - number_len);
+	data +=3D 10;
+
+	/* CCP1 unused */
+	*data++ =3D 0xff;
+	/* Ext1 unused */
+	*data++ =3D 0xff;
+}
diff --git a/src/simutil.h b/src/simutil.h
index c2b1e20..9d198db 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -82,3 +82,5 @@ static inline enum sim_file_access file_access_condition_=
decode(int bcd)
 =

 gboolean sim_adn_parse(const unsigned char *data, int length,
 			struct ofono_phone_number *ph);
+void sim_adn_build(unsigned char *data, int length,
+			const struct ofono_phone_number *ph);
diff --git a/src/smsutil.c b/src/smsutil.c
index ad38ed9..ba2bbc1 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -110,6 +110,17 @@ static inline int to_semi_oct(char in)
 	return digit;
 }
 =

+void encode_bcd_number(const char *number, unsigned char *out)
+{
+	while (number[0] !=3D '\0' && number[1] !=3D '\0') {
+		*out =3D to_semi_oct(*number++);
+		*out++ |=3D to_semi_oct(*number++) << 4;
+	}
+
+	if (*number)
+		*out =3D to_semi_oct(*number) | 0xf0;
+}
+
 /* Returns whether the DCS could be parsed successfully, e.g. no reserved
  * values were used
  */
@@ -446,8 +457,8 @@ static gboolean encode_validity_period(const struct sms=
_validity_period *vp,
 	return FALSE;
 }
 =

-static gboolean encode_address(const struct sms_address *in, gboolean sc,
-				unsigned char *pdu, int *offset)
+gboolean sms_encode_address_field(const struct sms_address *in, gboolean s=
c,
+					unsigned char *pdu, int *offset)
 {
 	size_t len =3D strlen(in->address);
 	unsigned char addr_len =3D 0;
@@ -533,9 +544,9 @@ out:
 	return TRUE;
 }
 =

-static gboolean decode_address(const unsigned char *pdu, int len,
-				int *offset, gboolean sc,
-				struct sms_address *out)
+gboolean sms_decode_address_field(const unsigned char *pdu, int len,
+					int *offset, gboolean sc,
+					struct sms_address *out)
 {
 	unsigned char addr_len;
 	unsigned char addr_type;
@@ -635,7 +646,7 @@ static gboolean encode_deliver(const struct sms_deliver=
 *in, unsigned char *pdu,
 =

 	set_octet(pdu, offset, oct);
 =

-	if (encode_address(&in->oaddr, FALSE, pdu, offset) =3D=3D FALSE)
+	if (sms_encode_address_field(&in->oaddr, FALSE, pdu, offset) =3D=3D FALSE)
 		return FALSE;
 =

 	set_octet(pdu, offset, in->pid);
@@ -672,7 +683,8 @@ static gboolean decode_deliver(const unsigned char *pdu=
, int len,
 	out->deliver.udhi =3D is_bit_set(octet, 6);
 	out->deliver.rp =3D is_bit_set(octet, 7);
 =

-	if (!decode_address(pdu, len, &offset, FALSE, &out->deliver.oaddr))
+	if (!sms_decode_address_field(pdu, len, &offset,
+					FALSE, &out->deliver.oaddr))
 		return FALSE;
 =

 	if (!next_octet(pdu, len, &offset, &out->deliver.pid))
@@ -883,7 +895,7 @@ static gboolean encode_status_report(const struct sms_s=
tatus_report *in,
 =

 	set_octet(pdu, offset, in->mr);
 =

-	if (!encode_address(&in->raddr, FALSE, pdu, offset))
+	if (!sms_encode_address_field(&in->raddr, FALSE, pdu, offset))
 		return FALSE;
 =

 	if (!encode_scts(&in->scts, pdu, offset))
@@ -935,8 +947,8 @@ static gboolean decode_status_report(const unsigned cha=
r *pdu, int len,
 	if (!next_octet(pdu, len, &offset, &out->status_report.mr))
 		return FALSE;
 =

-	if (!decode_address(pdu, len, &offset, FALSE,
-				&out->status_report.raddr))
+	if (!sms_decode_address_field(pdu, len, &offset, FALSE,
+					&out->status_report.raddr))
 		return FALSE;
 =

 	if (!decode_scts(pdu, len, &offset, &out->status_report.scts))
@@ -1173,7 +1185,7 @@ static gboolean encode_submit(const struct sms_submit=
 *in,
 =

 	set_octet(pdu, offset, in->mr);
 =

-	if (encode_address(&in->daddr, FALSE, pdu, offset) =3D=3D FALSE)
+	if (sms_encode_address_field(&in->daddr, FALSE, pdu, offset) =3D=3D FALSE)
 		return FALSE;
 =

 	set_octet(pdu, offset, in->pid);
@@ -1215,7 +1227,8 @@ static gboolean decode_submit(const unsigned char *pd=
u, int len,
 	if (!next_octet(pdu, len, &offset, &out->submit.mr))
 		return FALSE;
 =

-	if (!decode_address(pdu, len, &offset, FALSE, &out->submit.daddr))
+	if (!sms_decode_address_field(pdu, len, &offset,
+					FALSE, &out->submit.daddr))
 		return FALSE;
 =

 	if (!next_octet(pdu, len, &offset, &out->submit.pid))
@@ -1265,7 +1278,7 @@ static gboolean encode_command(const struct sms_comma=
nd *in,
 =

 	set_octet(pdu, offset, in->mn);
 =

-	if (!encode_address(&in->daddr, FALSE, pdu, offset))
+	if (!sms_encode_address_field(&in->daddr, FALSE, pdu, offset))
 		return FALSE;
 =

 	set_octet(pdu, offset, in->cdl);
@@ -1305,7 +1318,8 @@ static gboolean decode_command(const unsigned char *p=
du, int len,
 	if (!next_octet(pdu, len, &offset, &out->command.mn))
 		return FALSE;
 =

-	if (!decode_address(pdu, len, &offset, FALSE, &out->command.daddr))
+	if (!sms_decode_address_field(pdu, len, &offset,
+					FALSE, &out->command.daddr))
 		return FALSE;
 =

 	if (!next_octet(pdu, len, &offset, &out->command.cdl))
@@ -1328,7 +1342,7 @@ gboolean sms_encode(const struct sms *in, int *len, i=
nt *tpdu_len,
 =

 	if (in->type =3D=3D SMS_TYPE_DELIVER || in->type =3D=3D SMS_TYPE_SUBMIT ||
 			in->type =3D=3D SMS_TYPE_COMMAND)
-		if (!encode_address(&in->sc_addr, TRUE, pdu, &offset))
+		if (!sms_encode_address_field(&in->sc_addr, TRUE, pdu, &offset))
 			return FALSE;
 =

 	tpdu_start =3D offset;
@@ -1396,7 +1410,8 @@ gboolean sms_decode(const unsigned char *pdu, int len=
, gboolean outgoing,
 		return FALSE;
 =

 	if (tpdu_len < len) {
-		if (!decode_address(pdu, len, &offset, TRUE, &out->sc_addr))
+		if (!sms_decode_address_field(pdu, len, &offset,
+						TRUE, &out->sc_addr))
 			return FALSE;
 	}
 =

diff --git a/src/smsutil.h b/src/smsutil.h
index d362aa9..95d0c78 100644
--- a/src/smsutil.h
+++ b/src/smsutil.h
@@ -401,6 +401,7 @@ static inline unsigned char bit_field(unsigned char oct=
, int start, int num)
 }
 =

 void extract_bcd_number(const unsigned char *buf, int len, char *out);
+void encode_bcd_number(const char *number, unsigned char *out);
 =

 gboolean sms_decode(const unsigned char *pdu, int len, gboolean outgoing,
 			int tpdu_len, struct sms *out);
@@ -408,6 +409,13 @@ gboolean sms_decode(const unsigned char *pdu, int len,=
 gboolean outgoing,
 gboolean sms_encode(const struct sms *in, int *len, int *tpdu_len,
 			unsigned char *pdu);
 =

+gboolean sms_decode_address_field(const unsigned char *pdu, int len,
+					int *offset, gboolean sc,
+					struct sms_address *out);
+
+gboolean sms_encode_address_field(const struct sms_address *in, gboolean s=
c,
+					unsigned char *pdu, int *offset);
+
 int sms_udl_in_bytes(guint8 ud_len, guint8 dcs);
 =

 time_t sms_scts_to_time(const struct sms_scts *scts, struct tm *remote);
-- =

1.6.1


--===============8562366000391032564==--

