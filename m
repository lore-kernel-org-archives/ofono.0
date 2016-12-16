Content-Type: multipart/mixed; boundary="===============5746131664056594970=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: [PATCH] ublox:netmon: support +UCGED and get EARFCN, EBAND and CQI
Date: Fri, 16 Dec 2016 11:05:12 +0100
Message-ID: <1481882712-921-1-git-send-email-djalal@endocode.com>
In-Reply-To: <cc295040-bff1-5951-b1c4-d9baa29f85b1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5746131664056594970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds support for +UCGED mode 2 and for now we collect only
EARFCN, EBAND and CQI. Later we will follow up with +UCGED mode 3.

Some ublox modems supports +UCGED mode 2 and others only +UCGED mode 3
depending on the firmware.
---
 drivers/ubloxmodem/netmon.c | 210 ++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 206 insertions(+), 4 deletions(-)

diff --git a/drivers/ubloxmodem/netmon.c b/drivers/ubloxmodem/netmon.c
index 0749078..6fc3bad 100644
--- a/drivers/ubloxmodem/netmon.c
+++ b/drivers/ubloxmodem/netmon.c
@@ -46,6 +46,20 @@
 =

 static const char *cops_prefix[] =3D { "+COPS:", NULL };
 static const char *cesq_prefix[] =3D { "+CESQ:", NULL };
+static const char *ucged_prefix[] =3D { "+UCGED:", NULL };
+
+/*
+ * Generic function that should point to number or hexstring result
+ * parsers. Result should be returned as an int.
+ */
+typedef gboolean (*ucged_g_at_result_iter_next)(GAtResultIter *iter,
+						int *result);
+
+/* Field from +UCGED response */
+typedef struct ublox_ucged_value {
+	int offset;	/* Offset at response */
+	ucged_g_at_result_iter_next ucged_g_at_result_iter_next_field;
+} ublox_ucged_value;
 =

 struct netmon_driver_data {
 	GAtChat *chat;
@@ -67,6 +81,10 @@ struct req_cb_data {
 	int rsrp;	/* CESQ: Reference Signal Received Power */
 	int ecn0;	/* CESQ: Received Energy Ratio */
 	int rsrq;	/* CESQ: Reference Signal Received Quality */
+
+	int earfcn;	/* UCGED: E-UTRA ARFCN */
+	int eband;	/* UCGED: E-UTRA Band */
+	int cqi;	/* UCGED: Channel Quality Indicator */
 };
 =

 /*
@@ -102,6 +120,7 @@ static inline struct req_cb_data *req_cb_data_new0(void=
 *cb, void *data,
 	ret->cb =3D cb;
 	ret->data =3D data;
 	ret->netmon =3D user;
+
 	ret->rxlev =3D -1;
 	ret->ber =3D -1;
 	ret->rscp =3D -1;
@@ -109,6 +128,10 @@ static inline struct req_cb_data *req_cb_data_new0(voi=
d *cb, void *data,
 	ret->ecn0 =3D -1;
 	ret->rsrq =3D -1;
 =

+	ret->earfcn =3D -1;
+	ret->eband =3D -1;
+	ret->cqi =3D -1;
+
 	return ret;
 }
 =

@@ -157,11 +180,165 @@ static void ublox_netmon_finish_success(struct req_c=
b_data *cbd)
 					OFONO_NETMON_INFO_ECN0, cbd->ecn0,
 					OFONO_NETMON_INFO_RSRQ, cbd->rsrq,
 					OFONO_NETMON_INFO_RSRP, cbd->rsrp,
+					OFONO_NETMON_INFO_EARFCN, cbd->earfcn,
+					OFONO_NETMON_INFO_EBAND, cbd->eband,
+					OFONO_NETMON_INFO_CQI, cbd->cqi,
 					OFONO_NETMON_INFO_INVALID);
 =

 	CALLBACK_WITH_SUCCESS(cbd->cb, cbd->data);
 }
 =

+static void ucged_parse_4g(struct req_cb_data *cbd, GAtResultIter *iter)
+{
+	/* Offset of values in returned response */
+	enum ucged_mode2_rat4_offsets {
+		UCGED_EARFCN		=3D 0,
+		UCGED_EBAND		=3D 1,
+		UCGED_CQI		=3D 15,
+	};
+
+	ublox_ucged_value ucged_values[] =3D {
+		{ UCGED_EARFCN,	g_at_result_iter_next_number },
+		{ UCGED_EBAND,	g_at_result_iter_next_number },
+		{ UCGED_CQI,	g_at_result_iter_next_number },
+		{ -1,		NULL }, /* End of Array */
+	};
+
+	gboolean ok;
+	unsigned i;
+	ublox_ucged_value *cur;
+
+	/* Skip to next */
+	ok =3D g_at_result_iter_next(iter, NULL);
+	if (!ok) {
+		DBG(" UCGED:response: failed to go to next line ");
+		return;
+	}
+
+	i =3D 0;
+	cur =3D &ucged_values[0];
+	while (cur->offset >=3D 0) {
+		int number;
+
+		/* Skip values that we do not want */
+		while (i !=3D (unsigned) cur->offset) {
+			ok =3D g_at_result_iter_skip_next(iter);
+			if (!ok) {
+				DBG(" UCGED: error skip idx: %d ", i);
+				return;
+			}
+			i++;
+		}
+
+		ok =3D cur->ucged_g_at_result_iter_next_field(iter, &number);
+		if (!ok) {
+			DBG(" UCGED: error parsing at idx: %d ", i);
+			return;
+		}
+
+		switch (i) {
+		case UCGED_EARFCN:
+			cbd->earfcn =3D number !=3D 65535 ? number : cbd->earfcn;
+			break;
+		case UCGED_EBAND:
+			cbd->eband =3D number !=3D 255 ? number : cbd->eband;
+			break;
+		case UCGED_CQI:
+			cbd->cqi =3D number !=3D 255 ? number : cbd->cqi;
+			break;
+		}
+
+		i++;
+		cur++;
+	}
+
+	/*
+	 * Sample output for +UCGED MODE 2 will be:
+	 *
+	 *	UCGED: MODE 2 RAT =3D 4G	EARFCN =3D 1300
+	 *	UCGED: MODE 2 RAT =3D 4G	EBAND =3D 3
+	 *	UCGED: MODE 2 RAT =3D 4G	CQI =3D -1
+	 *
+	 * Check the networkmonitor-api documentation and the related
+	 * references for mode details.
+	 */
+	DBG(" UCGED: MODE 2 RAT =3D 4G	EARFCN =3D %d ", cbd->earfcn);
+	DBG(" UCGED: MODE 2 RAT =3D 4G	EBAND =3D %d ", cbd->eband);
+	DBG(" UCGED: MODE 2 RAT =3D 4G	CQI =3D %d ", cbd->cqi);
+}
+
+static void ucged_collect_mode2_data(struct req_cb_data *cbd,
+					GAtResultIter *iter)
+{
+	int rat;
+	gboolean ok;
+
+	ok =3D g_at_result_iter_next(iter, NULL);
+	if (!ok) {
+		DBG(" UCGED:response: failed to go to next line ");
+		return;
+	}
+
+	ok =3D g_at_result_iter_next_number(iter, &rat);
+	if (!ok) {
+		DBG(" UCGED: error parsing 'RAT' ");
+		return;
+	}
+
+	/* For now we support only RAT 4 */
+	if (rat !=3D 4) {
+		DBG(" UCGED: 'RAT' is %d, nothing to do. ", rat);
+		return;
+	}
+
+	DBG(" UCGED: 'RAT' is %d ", rat);
+	ucged_parse_4g(cbd, iter);
+}
+
+static void ucged_query_mode2_cb(gboolean ok, GAtResult *result,
+					gpointer user_data)
+{
+	struct req_cb_data *cbd =3D user_data;
+	struct ofono_error error;
+	GAtResultIter iter;
+	int mode;
+
+	DBG("ok %d", ok);
+
+	decode_at_error(&error, g_at_result_final_response(result));
+
+	if (!ok) {
+		DBG(" UCGED: failed ");
+		goto out;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+UCGED:")) {
+		DBG(" UCGED: no result ");
+		goto out;
+	}
+
+	ok =3D g_at_result_iter_next_number(&iter, &mode);
+	if (!ok) {
+		DBG(" UCGED: error parsing 'mode' ");
+		goto out;
+	}
+
+	DBG(" UCGED:  report mode is %d ", mode);
+
+	/* mode 2 collect +UCGED data */
+	if (mode =3D=3D 2)
+		ucged_collect_mode2_data(cbd, &iter);
+
+	/*
+	 * We never fail at this point we always send what we collected so
+	 * far
+	 */
+out:
+	ublox_netmon_finish_success(cbd);
+}
+
 static void cesq_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	enum cesq_ofono_netmon_info {
@@ -175,6 +352,8 @@ static void cesq_cb(gboolean ok, GAtResult *result, gpo=
inter user_data)
 	};
 =

 	struct req_cb_data *cbd =3D user_data;
+	struct ofono_netmon *nm =3D cbd->netmon;
+	struct netmon_driver_data *nmd =3D ofono_netmon_get_data(nm);
 	struct ofono_error error;
 	GAtResultIter iter;
 	int idx, number;
@@ -233,10 +412,17 @@ static void cesq_cb(gboolean ok, GAtResult *result, g=
pointer user_data)
 	DBG(" RSRQ	%d ", cbd->rsrq);
 	DBG(" RSRP	%d ", cbd->rsrp);
 =

-	/*
-	 * We never fail at this point we always send what we collected so
-	 * far
-	 */
+	cbd =3D req_cb_data_ref(cbd);
+	if (g_at_chat_send(nmd->chat, "AT+UCGED?", NULL,
+			ucged_query_mode2_cb, cbd, req_cb_data_unref) =3D=3D 0) {
+		/* We never fail, we always send what we collected so far */
+		ofono_error("%s: send +UCGED failed", __func__);
+		req_cb_data_unref(cbd);
+		goto out;
+	}
+
+	return;
+
 out:
 	ublox_netmon_finish_success(cbd);
 }
@@ -320,6 +506,22 @@ static int ublox_netmon_probe(struct ofono_netmon *net=
mon,
 =

 	g_idle_add(ublox_delayed_register, netmon);
 =

+	/*
+	 * We set +UCGED=3D2 mode as early as possible so we are able to handle
+	 * the following:
+	 * 1) In case the modem supports only +UCGED mode 2 then we have
+	 *    already set the appropriate mode and we can query the information
+	 *    later.
+	 * 2) In case the modem supports only +UCGED mode 3, then to set mode 3
+	 *    the modem has to be first in +UCGED mode 2. Setting the mode here
+	 *    allows later to query the information and on errors we fallback
+	 *    to mode 3.
+	 *
+	 * This should handle current firmware versions of ublox modems.
+	 */
+	g_at_chat_send(nmd->chat, "AT+UCGED=3D2", ucged_prefix,
+			NULL, NULL, NULL);
+
 	return 0;
 }
 =

-- =

2.5.5


--===============5746131664056594970==--

