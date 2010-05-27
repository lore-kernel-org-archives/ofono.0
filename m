Content-Type: multipart/mixed; boundary="===============2576758749647271885=="
MIME-Version: 1.0
From: Pekka Pessi <Pekka.Pessi@nokia.com>
Subject: [PATCH 4/6] Eliminated bool, true and false from isimodem.
Date: Thu, 27 May 2010 19:12:46 +0300
Message-ID: <1274976768-1555-4-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1274976768-1555-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2576758749647271885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/call-barring.c         |   29 ++++----
 drivers/isimodem/call-forwarding.c      |   38 ++++++-----
 drivers/isimodem/call-settings.c        |   16 +++--
 drivers/isimodem/cbs.c                  |   18 +++--
 drivers/isimodem/devinfo.c              |   15 ++--
 drivers/isimodem/gprs-context.c         |  103 +++++++++++++++-------------
 drivers/isimodem/gprs.c                 |   35 ++++++----
 drivers/isimodem/infoserver.c           |    2 +-
 drivers/isimodem/isimodem.c             |   31 +++++----
 drivers/isimodem/network-registration.c |   91 ++++++++++++++-----------
 drivers/isimodem/phonebook.c            |   13 ++--
 drivers/isimodem/radio-settings.c       |   24 ++++---
 drivers/isimodem/sim.c                  |   51 ++++++++------
 drivers/isimodem/sms.c                  |   65 ++++++++++--------
 drivers/isimodem/ussd.c                 |   19 +++--
 drivers/isimodem/voicecall.c            |  114 +++++++++++++++------------=
---
 16 files changed, 359 insertions(+), 305 deletions(-)

diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index cf6a0e0..894f963 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -70,8 +70,9 @@ static int lock_code_to_mmi(char const *lock)
 		return 0;
 }
 =

-static bool set_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean set_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -83,7 +84,7 @@ static bool set_resp_cb(GIsiClient *client, const void *r=
estrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D SS_ACTIVATION && msg[1] !=3D SS_DEACTIVATION)
 		goto error;
@@ -96,7 +97,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 =

@@ -177,8 +178,9 @@ static void update_status_mask(unsigned int *mask, int =
bsc)
 	}
 }
 =

-static bool query_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean query_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	GIsiSubBlockIter iter;
 	const unsigned char *msg =3D data;
@@ -193,7 +195,7 @@ static bool query_resp_cb(GIsiClient *client, const voi=
d *restrict data,
 	}
 =

 	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D SS_INTERROGATION)
 		goto error;
@@ -247,7 +249,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 =

 }
 =

@@ -277,8 +279,9 @@ static void isi_query(struct ofono_call_barring *barr, =
const char *lock,
 	g_free(cbd);
 }
 =

-static bool set_passwd_resp_cb(GIsiClient *client, const void *restrict da=
ta,
-				size_t len, uint16_t object, void *opaque)
+static gboolean set_passwd_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -290,7 +293,7 @@ static bool set_passwd_resp_cb(GIsiClient *client, cons=
t void *restrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D SS_GSM_PASSWORD_REGISTRATION)
 		goto error;
@@ -303,7 +306,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_set_passwd(struct ofono_call_barring *barr, const char *lo=
ck,
@@ -353,7 +356,7 @@ static gboolean isi_call_barring_register(gpointer user)
 	return FALSE;
 }
 =

-static void reachable_cb(GIsiClient *client, bool alive, uint16_t object,
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
 				void *opaque)
 {
 	struct ofono_call_barring *barr =3D opaque;
diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 61d3cfa..aaf6ed8 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -77,9 +77,10 @@ static int forw_type_to_isi_code(int type)
 	return ss_code;
 }
 =

-static bool decode_gsm_forwarding_info(const void *restrict data, size_t l=
en,
-					uint8_t *status, uint8_t *ton,
-					uint8_t *norply, char **number)
+static gboolean decode_gsm_forwarding_info(const void *restrict data,
+						size_t len,
+						uint8_t *status, uint8_t *ton,
+						uint8_t *norply, char **number)
 {
 	GIsiSubBlockIter iter;
 =

@@ -103,7 +104,7 @@ static bool decode_gsm_forwarding_info(const void *rest=
rict data, size_t len,
 				|| !g_isi_sb_iter_get_byte(&iter, &_numlen, 7)
 				|| !g_isi_sb_iter_get_alpha_tag(&iter, &_number,
 					_numlen * 2, 10))
-				return false;
+				return FALSE;
 =

 			if (status)
 				*status =3D _status;
@@ -116,7 +117,7 @@ static bool decode_gsm_forwarding_info(const void *rest=
rict data, size_t len,
 			else
 				g_free(_number);
 =

-			return true;
+			return TRUE;
 		}
 		default:
 			DBG("Skipping sub-block: %s (%zd bytes)",
@@ -125,11 +126,12 @@ static bool decode_gsm_forwarding_info(const void *re=
strict data, size_t len,
 			break;
 		}
 	}
-	return false;
+	return FALSE;
 }
 =

-static bool registration_resp_cb(GIsiClient *client, const void *restrict =
data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean registration_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	GIsiSubBlockIter iter;
 	const unsigned char *msg =3D data;
@@ -142,7 +144,7 @@ static bool registration_resp_cb(GIsiClient *client, co=
nst void *restrict data,
 	}
 =

 	if (len < 7 || msg[0] !=3D SS_SERVICE_COMPLETED_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D SS_REGISTRATION)
 		goto error;
@@ -193,7 +195,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_registration(struct ofono_call_forwarding *cf,
@@ -260,8 +262,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool erasure_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean erasure_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	GIsiSubBlockIter iter;
 	const unsigned char *msg =3D data;
@@ -324,7 +327,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 =

@@ -365,8 +368,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool query_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean query_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	GIsiSubBlockIter iter;
 	const unsigned char *msg =3D data;
@@ -454,7 +458,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 =

 }
 =

@@ -506,7 +510,7 @@ static gboolean isi_call_forwarding_register(gpointer u=
ser)
 	return FALSE;
 }
 =

-static void reachable_cb(GIsiClient *client, bool alive, uint16_t object,
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
 				void *opaque)
 {
 	struct ofono_call_forwarding *cf =3D opaque;
diff --git a/drivers/isimodem/call-settings.c b/drivers/isimodem/call-setti=
ngs.c
index 651d0ec..73f340f 100644
--- a/drivers/isimodem/call-settings.c
+++ b/drivers/isimodem/call-settings.c
@@ -89,8 +89,9 @@ static void update_status_mask(unsigned int *mask, int bs=
c)
 	}
 }
 =

-static bool query_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean query_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	GIsiSubBlockIter iter;
 	const unsigned char *msg =3D data;
@@ -154,7 +155,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 =

 }
 =

@@ -188,8 +189,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool set_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean set_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	GIsiSubBlockIter iter;
 	const unsigned char *msg =3D data;
@@ -244,7 +246,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 =

 }
 =

@@ -287,7 +289,7 @@ static gboolean isi_call_settings_register(gpointer use=
r)
 	return FALSE;
 }
 =

-static void reachable_cb(GIsiClient *client, bool alive, uint16_t object,
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
 				void *opaque)
 {
 	struct ofono_call_settings *cs =3D opaque;
diff --git a/drivers/isimodem/cbs.c b/drivers/isimodem/cbs.c
index 98565c7..186ba70 100644
--- a/drivers/isimodem/cbs.c
+++ b/drivers/isimodem/cbs.c
@@ -61,8 +61,9 @@ static void isi_clear_topics(struct ofono_cbs *cbs,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void routing_ntf_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static void routing_ntf_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct ofono_cbs *cbs =3D opaque;
@@ -73,19 +74,20 @@ static void routing_ntf_cb(GIsiClient *client, const vo=
id *restrict data,
 	ofono_cbs_notify(cbs, msg+5, len-5);
 }
 =

-static bool routing_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean routing_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct ofono_cbs *cbs =3D opaque;
 =

 	if (!msg) {
 		DBG("ISI client error: %d", g_isi_client_error(client));
-		return true;
+		return TRUE;
 	}
 =

 	if (len < 3 || msg[0] !=3D SMS_GSM_CB_ROUTING_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D SMS_OK) {
 		if (msg[1] =3D=3D SMS_ERR_PP_RESERVED)
@@ -96,14 +98,14 @@ static bool routing_resp_cb(GIsiClient *client, const v=
oid *restrict data,
 				"routing endpoint.\n  As a consequence, "
 				"receiving CBSs is NOT going to work.\n\n",
 				msg[1], sms_isi_cause_name(msg[1]));
-		return true;
+		return TRUE;
 	}
 =

 	g_isi_subscribe(client, SMS_GSM_CB_ROUTING_NTF, routing_ntf_cb,
 			cbs);
 =

 	ofono_cbs_register(cbs);
-	return true;
+	return TRUE;
 }
 =

 static int isi_cbs_probe(struct ofono_cbs *cbs, unsigned int vendor,
diff --git a/drivers/isimodem/devinfo.c b/drivers/isimodem/devinfo.c
index c05ab3c..bc5cdae 100644
--- a/drivers/isimodem/devinfo.c
+++ b/drivers/isimodem/devinfo.c
@@ -47,8 +47,9 @@ struct devinfo_data {
 	GIsiClient *client;
 };
 =

-static bool info_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean info_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -65,13 +66,13 @@ static bool info_resp_cb(GIsiClient *client, const void=
 *restrict data,
 =

 	if (len < 3) {
 		DBG("truncated message");
-		return false;
+		return FALSE;
 	}
 =

 	if (msg[0] !=3D INFO_PRODUCT_INFO_READ_RESP
 		&& msg[0] !=3D INFO_VERSION_READ_RESP
 		&& msg[0] !=3D INFO_SERIAL_NUMBER_READ_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D INFO_OK) {
 		DBG("request failed: %s", info_isi_cause_name(msg[1]));
@@ -99,7 +100,7 @@ static bool info_resp_cb(GIsiClient *client, const void =
*restrict data,
 			g_free(info);
 =

 			g_free(cbd);
-			return true;
+			return TRUE;
 =

 		default:
 			DBG("skipping: %s (%zu bytes)",
@@ -112,7 +113,7 @@ static bool info_resp_cb(GIsiClient *client, const void=
 *restrict data,
 error:
 	CALLBACK_WITH_FAILURE(cb, "", cbd->data);
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_query_manufacturer(struct ofono_devinfo *info,
@@ -227,7 +228,7 @@ static gboolean isi_devinfo_register(gpointer user)
 	return FALSE;
 }
 =

-static void reachable_cb(GIsiClient *client, bool alive, uint16_t object,
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
 				void *opaque)
 {
 	struct ofono_devinfo *info =3D opaque;
diff --git a/drivers/isimodem/gprs-context.c b/drivers/isimodem/gprs-contex=
t.c
index df6ff79..1e1225b 100644
--- a/drivers/isimodem/gprs-context.c
+++ b/drivers/isimodem/gprs-context.c
@@ -124,7 +124,7 @@ static void destroy_context(struct context_data *cd)
 	g_free(cd);
 }
 =

-static bool gprs_up_fail(struct context_data *cd)
+static gboolean gprs_up_fail(struct context_data *cd)
 {
 	struct ofono_gprs_context *gc =3D cd->driver;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
@@ -134,10 +134,10 @@ static bool gprs_up_fail(struct context_data *cd)
 =

 	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
 	destroy_context(cd);
-	return true;
+	return TRUE;
 }
 =

-static bool gprs_down_fail(struct context_data *cd)
+static gboolean gprs_down_fail(struct context_data *cd)
 {
 	struct ofono_gprs_context *gc =3D cd->driver;
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
@@ -146,33 +146,33 @@ static bool gprs_down_fail(struct context_data *cd)
 =

 	gcd->contexts =3D g_slist_remove(gcd->contexts, cd);
 	destroy_context(cd);
-	return true;
+	return TRUE;
 }
 =

-static bool check_resp(GIsiClient *client,
-			const uint8_t *restrict msg, size_t len,
-			uint_fast8_t cmd, struct context_data *cd)
+static gboolean check_resp(GIsiClient *client,
+				const uint8_t *restrict msg, size_t len,
+				uint_fast8_t cmd, struct context_data *cd)
 {
 	if (!msg) {
 		DBG("ISI client error: %d", g_isi_client_error(client));
-		return false;
+		return FALSE;
 	}
 =

 	if (len < 3) {
 		DBG("truncated message");
-		return false;
+		return FALSE;
 	}
 =

 	if (msg[0] !=3D cmd) {
 		DBG("unexpected message ID: %s (0x%02"PRIx8")",
 			gpds_message_id_name(msg[0]), msg[0]);
-		return false;
+		return FALSE;
 	}
 =

 	if ((cd->handle !=3D INVALID_ID && msg[1] !=3D cd->handle)
 		|| (msg[1] =3D=3D INVALID_ID)) {
 		DBG("invalid context ID: 0x%02"PRIx8, msg[1]);
-		return false;
+		return FALSE;
 	}
 =

 	if (msg[2] !=3D GPDS_OK) {
@@ -183,13 +183,14 @@ static bool check_resp(GIsiClient *client,
 			DBG("  fail cause: %s (0x%02"PRIx8")",
 				gpds_isi_cause_name(msg[3]), msg[3]);
 =

-		return false;
+		return FALSE;
 	}
-	return true;
+	return TRUE;
 }
 =

-static void activate_ind_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static void activate_ind_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	struct gprs_context_data *gcd =3D opaque;
 	struct context_data *cd;
@@ -278,9 +279,9 @@ error:
 	gprs_up_fail(cd);
 }
 =

-static void activate_fail_ind_cb(GIsiClient *client, const void *restrict =
data,
-					size_t len, uint16_t object,
-					void *opaque)
+static void activate_fail_ind_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct gprs_context_data *gcd =3D opaque;
@@ -298,8 +299,9 @@ static void activate_fail_ind_cb(GIsiClient *client, co=
nst void *restrict data,
 	gprs_up_fail(cd);
 }
 =

-static bool context_activate_cb(GIsiClient *client, const void *restrict d=
ata,
-				size_t len, uint16_t object, void *opaque)
+static gboolean context_activate_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	struct context_data *cd =3D opaque;
 =

@@ -308,10 +310,10 @@ static bool context_activate_cb(GIsiClient *client, c=
onst void *restrict data,
 =

 	/* TODO: Add timeout here in case indications never come */
 =

-	return true;
+	return TRUE;
 }
 =

-static bool send_context_activate(GIsiClient *client, void *opaque)
+static void send_context_activate(GIsiClient *client, void *opaque)
 {
 	struct context_data *cd =3D opaque;
 =

@@ -321,16 +323,16 @@ static bool send_context_activate(GIsiClient *client,=
 void *opaque)
 		0,		/* sub blocks */
 	};
 =

-	if (!g_isi_request_make(client, msg, sizeof(msg), GPDS_TIMEOUT,
+	if (g_isi_request_make(client, msg, sizeof(msg), GPDS_TIMEOUT,
 				context_activate_cb, cd))
-		return gprs_up_fail(cd);
-
-	g_isi_pipe_start(cd->pipe);
-	return true;
+		g_isi_pipe_start(cd->pipe);
+	else
+		gprs_up_fail(cd);
 }
 =

-static bool context_auth_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean context_auth_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	struct context_data *cd =3D opaque;
 =

@@ -338,10 +340,10 @@ static bool context_auth_cb(GIsiClient *client, const=
 void *restrict data,
 		return gprs_up_fail(cd);
 =

 	send_context_activate(client, cd);
-	return true;
+	return TRUE;
 }
 =

-static bool send_context_authenticate(GIsiClient *client, void *opaque)
+static void send_context_authenticate(GIsiClient *client, void *opaque)
 {
 	struct context_data *cd =3D opaque;
 	size_t username_len =3D strlen(cd->username);
@@ -373,13 +375,12 @@ static bool send_context_authenticate(GIsiClient *cli=
ent, void *opaque)
 =

 	if (!g_isi_request_vmake(client, iov, 4, GPDS_TIMEOUT,
 					context_auth_cb, cd))
-		return gprs_up_fail(cd);
-
-	return true;
+		gprs_up_fail(cd);
 }
 =

-static bool context_conf_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean context_conf_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	struct context_data *cd =3D opaque;
 =

@@ -391,11 +392,12 @@ static bool context_conf_cb(GIsiClient *client, const=
 void *restrict data,
 	else
 		send_context_activate(client, cd);
 =

-	return true;
+	return TRUE;
 }
 =

-static bool link_conf_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean link_conf_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	struct context_data *cd =3D opaque;
 	size_t apn_len =3D strlen(cd->apn);
@@ -428,11 +430,12 @@ static bool link_conf_cb(GIsiClient *client, const vo=
id *restrict data,
 					context_conf_cb, cd))
 		return gprs_up_fail(cd);
 =

-	return true;
+	return TRUE;
 }
 =

-static bool create_context_cb(GIsiClient *client, const void *restrict dat=
a,
-				size_t len, uint16_t object, void *opaque)
+static gboolean create_context_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *resp =3D data;
 	struct context_data *cd =3D opaque;
@@ -455,7 +458,7 @@ static bool create_context_cb(GIsiClient *client, const=
 void *restrict data,
 =

 	/* TODO: send context configuration at the same time? */
 =

-	return true;
+	return TRUE;
 }
 =

 static void create_pipe_cb(GIsiPipe *pipe)
@@ -473,8 +476,9 @@ static void create_pipe_cb(GIsiPipe *pipe)
 		gprs_up_fail(cd);
 }
 =

-static void deactivate_ind_cb(GIsiClient *client, const void *restrict dat=
a,
-				size_t len, uint16_t object, void *opaque)
+static void deactivate_ind_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	struct gprs_context_data *gcd =3D opaque;
 	struct context_data *cd;
@@ -559,8 +563,9 @@ error:
 	gprs_up_fail(cd);
 }
 =

-static bool context_deactivate_cb(GIsiClient *client, const void *restrict=
 data,
-					size_t len, uint16_t object,
+static gboolean context_deactivate_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object,
 					void *opaque)
 {
 	struct context_data *cd =3D opaque;
@@ -575,7 +580,7 @@ static bool context_deactivate_cb(GIsiClient *client, c=
onst void *restrict data,
 	CALLBACK_WITH_SUCCESS(cd->down_cb, cd->data);
 	destroy_context(cd);
 =

-	return true;
+	return TRUE;
 }
 =

 static void isi_gprs_deactivate_primary(struct ofono_gprs_context *gc,
@@ -606,7 +611,7 @@ static void isi_gprs_deactivate_primary(struct ofono_gp=
rs_context *gc,
 		gprs_down_fail(cd);
 }
 =

-static void gpds_ctx_reachable_cb(GIsiClient *client, bool alive,
+static void gpds_ctx_reachable_cb(GIsiClient *client, gboolean alive,
 					uint16_t object,
 					void *opaque)
 {
diff --git a/drivers/isimodem/gprs.c b/drivers/isimodem/gprs.c
index 2aafd6d..3f79972 100644
--- a/drivers/isimodem/gprs.c
+++ b/drivers/isimodem/gprs.c
@@ -45,8 +45,9 @@ struct gprs_data {
 	GIsiClient *client;
 };
 =

-static void detach_ind_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static void detach_ind_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	/*struct ofono_gprs *gprs =3D opaque;*/
 	const unsigned char *msg =3D data;
@@ -78,7 +79,8 @@ static gboolean isi_gprs_register(gpointer user)
 	return FALSE;
 }
 =

-static void gpds_reachable_cb(GIsiClient *client, bool alive, uint16_t obj=
ect,
+static void gpds_reachable_cb(GIsiClient *client,
+				gboolean alive, uint16_t object,
 				void *opaque)
 {
 	struct ofono_gprs *gprs =3D opaque;
@@ -132,8 +134,9 @@ static void isi_gprs_remove(struct ofono_gprs *gprs)
 	g_free(data);
 }
 =

-static bool attach_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean attach_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -145,7 +148,7 @@ static bool attach_resp_cb(GIsiClient *client, const vo=
id *restrict data,
 	}
 =

 	if (len !=3D 4 || msg[0] !=3D GPDS_ATTACH_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D GPDS_OK) {
 		DBG("attach failed: %s", gpds_status_name(msg[1]));
@@ -160,11 +163,12 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

-static bool detach_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean detach_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -176,7 +180,7 @@ static bool detach_resp_cb(GIsiClient *client, const vo=
id *restrict data,
 	}
 =

 	if (len !=3D 3 || msg[0] !=3D GPDS_DETACH_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D GPDS_OK) {
 		DBG("detach failed: %s", gpds_status_name(msg[1]));
@@ -191,7 +195,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static GIsiRequest *attach_request_make(GIsiClient *client, void *data)
@@ -241,8 +245,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool status_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean status_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -254,7 +259,7 @@ static bool status_resp_cb(GIsiClient *client, const vo=
id *restrict data,
 	}
 =

 	if (len < 2 || msg[0] !=3D GPDS_STATUS_RESP)
-		return false;
+		return FALSE;
 =

 	/* FIXME: the core still expects reg status, and not a boolean
 	 * attached status here.*/
@@ -269,7 +274,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_gprs_attached_status(struct ofono_gprs *gprs,
diff --git a/drivers/isimodem/infoserver.c b/drivers/isimodem/infoserver.c
index 35dd98d..9100485 100644
--- a/drivers/isimodem/infoserver.c
+++ b/drivers/isimodem/infoserver.c
@@ -43,7 +43,7 @@ struct isi_infoserver {
 	unsigned sv;	/* Software version in 0..98 */
 };
 =

-static bool serial_number_read_req(GIsiServer *server, void const *data,
+static gboolean serial_number_read_req(GIsiServer *server, void const *dat=
a,
 					size_t len, GIsiIncoming *irq,
 					void *opaque)
 {
diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index 9a5e87e..05ebfe2 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -96,8 +96,9 @@ static void set_power_by_mtc_state(struct isi_data *isi, =
int state)
 	}
 }
 =

-static void mtc_state_ind_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static void mtc_state_ind_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_data *isi =3D opaque;
@@ -120,8 +121,9 @@ static void mtc_state_ind_cb(GIsiClient *client, const =
void *restrict data,
 	}
 }
 =

-static bool mtc_poll_query_cb(GIsiClient *client, const void *restrict dat=
a,
-				size_t len, uint16_t object, void *opaque)
+static gboolean mtc_poll_query_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_data *isi =3D opaque;
@@ -132,7 +134,7 @@ static bool mtc_poll_query_cb(GIsiClient *client, const=
 void *restrict data,
 		};
 =

 		if (isi->linkstate !=3D PN_LINK_UP)
-			return true;
+			return TRUE;
 =

 		isi->interval *=3D 2;
 		if (isi->interval >=3D 20)
@@ -142,11 +144,11 @@ static bool mtc_poll_query_cb(GIsiClient *client, con=
st void *restrict data,
 					isi->interval,
 					mtc_poll_query_cb, opaque);
 =

-		return true;
+		return TRUE;
 	}
 =

 	if (len < 3 || msg[0] !=3D MTC_STATE_QUERY_RESP)
-		return false;
+		return FALSE;
 =

 	g_isi_subscribe(client, MTC_STATE_INFO_IND, mtc_state_ind_cb, opaque);
 =

@@ -157,22 +159,23 @@ static bool mtc_poll_query_cb(GIsiClient *client, con=
st void *restrict data,
 =

 	set_power_by_mtc_state(isi, msg[1]);
 =

-	return true;
+	return TRUE;
 }
 =

-static bool mtc_query_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean mtc_query_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_data *isi =3D opaque;
 =

 	if (!msg) {
 		DBG("ISI client error: %d", g_isi_client_error(client));
-		return true;
+		return TRUE;
 	}
 =

 	if (len < 3 || msg[0] !=3D MTC_STATE_QUERY_RESP)
-		return false;
+		return FALSE;
 =

 	DBG("current modem state: %s (0x%02X)",
 		mtc_modem_state_name(msg[1]), msg[1]);
@@ -181,10 +184,10 @@ static bool mtc_query_cb(GIsiClient *client, const vo=
id *restrict data,
 =

 	set_power_by_mtc_state(isi, msg[1]);
 =

-	return true;
+	return TRUE;
 }
 =

-static void reachable_cb(GIsiClient *client, bool alive, uint16_t object,
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
 				void *opaque)
 {
 	struct isi_data *isi =3D opaque;
diff --git a/drivers/isimodem/network-registration.c b/drivers/isimodem/net=
work-registration.c
index 75dd6bc..4898d42 100644
--- a/drivers/isimodem/network-registration.c
+++ b/drivers/isimodem/network-registration.c
@@ -181,8 +181,9 @@ static gboolean decode_reg_status(struct netreg_data *n=
d, const guint8 *msg,
 	return TRUE;
 }
 =

-static void reg_status_ind_cb(GIsiClient *client, const void *restrict dat=
a,
-				size_t len, uint16_t object, void *opaque)
+static void reg_status_ind_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct ofono_netreg *netreg =3D opaque;
@@ -202,8 +203,9 @@ static void reg_status_ind_cb(GIsiClient *client, const=
 void *restrict data,
 	}
 }
 =

-static bool reg_status_resp_cb(GIsiClient *client, const void *restrict da=
ta,
-				size_t len, uint16_t object, void *opaque)
+static gboolean reg_status_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -222,7 +224,7 @@ static bool reg_status_resp_cb(GIsiClient *client, cons=
t void *restrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D NET_REG_STATUS_GET_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D NET_CAUSE_OK) {
 		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
@@ -241,7 +243,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_registration_status(struct ofono_netreg *netreg,
@@ -268,8 +270,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool name_get_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean name_get_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -288,7 +291,7 @@ static bool name_get_resp_cb(GIsiClient *client, const =
void *restrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D NET_OPER_NAME_READ_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D NET_CAUSE_OK) {
 		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
@@ -339,7 +342,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 =

@@ -373,8 +376,9 @@ error:
 }
 =

 =

-static bool available_resp_cb(GIsiClient *client, const void *restrict dat=
a,
-				size_t len, uint16_t object, void *opaque)
+static gboolean available_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -392,7 +396,7 @@ static bool available_resp_cb(GIsiClient *client, const=
 void *restrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D NET_AVAILABLE_GET_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D NET_CAUSE_OK) {
 		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
@@ -460,7 +464,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_list_operators(struct ofono_netreg *netreg,
@@ -493,8 +497,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool set_auto_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean set_auto_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -507,7 +512,7 @@ static bool set_auto_resp_cb(GIsiClient *client, const =
void *restrict data,
 	}
 =

 	if (!msg || len < 3 || msg[0] !=3D NET_SET_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D NET_CAUSE_OK) {
 		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
@@ -523,7 +528,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_register_auto(struct ofono_netreg *netreg,
@@ -558,8 +563,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool set_manual_resp_cb(GIsiClient *client, const void *restrict da=
ta,
-				size_t len, uint16_t object, void *opaque)
+static gboolean set_manual_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -573,7 +579,7 @@ static bool set_manual_resp_cb(GIsiClient *client, cons=
t void *restrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D NET_SET_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D NET_CAUSE_OK) {
 		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
@@ -589,7 +595,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_register_manual(struct ofono_netreg *netreg,
@@ -638,8 +644,9 @@ static void isi_deregister(struct ofono_netreg *netreg,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void rat_ind_cb(GIsiClient *client, const void *restrict data,
-			size_t len, uint16_t object, void *opaque)
+static void rat_ind_cb(GIsiClient *client,
+			const void *restrict data, size_t len,
+			uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct ofono_netreg *netreg =3D opaque;
@@ -682,8 +689,9 @@ static void rat_ind_cb(GIsiClient *client, const void *=
restrict data,
 	}
 }
 =

-static bool rat_resp_cb(GIsiClient *client, const void *restrict data,
-			size_t len, uint16_t object, void *opaque)
+static gboolean rat_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct ofono_netreg *netreg =3D opaque;
@@ -693,15 +701,15 @@ static bool rat_resp_cb(GIsiClient *client, const voi=
d *restrict data,
 =

 	if (!msg) {
 		DBG("ISI client error: %d", g_isi_client_error(client));
-		return true;
+		return TRUE;
 	}
 =

 	if (len < 3 || msg[0] !=3D NET_RAT_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D NET_CAUSE_OK) {
 		DBG("Request failed: %s", net_isi_cause_name(msg[1]));
-		return true;
+		return TRUE;
 	}
 =

 	g_isi_sb_iter_init(&iter, msg, len, 3);
@@ -718,7 +726,7 @@ static bool rat_resp_cb(GIsiClient *client, const void =
*restrict data,
 				|| !info
 				|| !g_isi_sb_iter_get_byte(&iter,
 							&nd->gsm_compact, 4))
-				return true;
+				return TRUE;
 =

 			break;
 		}
@@ -731,11 +739,12 @@ static bool rat_resp_cb(GIsiClient *client, const voi=
d *restrict data,
 		}
 		g_isi_sb_iter_next(&iter);
 	}
-	return true;
+	return TRUE;
 }
 =

-static void rssi_ind_cb(GIsiClient *client, const void *restrict data,
-			size_t len, uint16_t object, void *opaque)
+static void rssi_ind_cb(GIsiClient *client,
+			const void *restrict data, size_t len,
+			uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct ofono_netreg *netreg =3D opaque;
@@ -746,8 +755,9 @@ static void rssi_ind_cb(GIsiClient *client, const void =
*restrict data,
 	ofono_netreg_strength_notify(netreg, msg[1]);
 }
 =

-static void time_ind_cb(GIsiClient *client, const void *restrict data,
-			size_t len, uint16_t object, void *opaque)
+static void time_ind_cb(GIsiClient *client,
+			const void *restrict data, size_t len,
+			uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	const unsigned char *nitz =3D msg + 3;
@@ -784,8 +794,9 @@ static void time_ind_cb(GIsiClient *client, const void =
*restrict data,
 	ofono_netreg_time_notify(netreg, &info);
 }
 =

-static bool rssi_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean rssi_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -800,7 +811,7 @@ static bool rssi_resp_cb(GIsiClient *client, const void=
 *restrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D NET_RSSI_GET_RESP)
-		return false;
+		return FALSE;
 =

 	if (msg[1] !=3D NET_CAUSE_OK) {
 		DBG("Request failed: %s (0x%02X)",
@@ -841,7 +852,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_strength(struct ofono_netreg *netreg,
@@ -902,7 +913,7 @@ static gboolean isi_netreg_register(gpointer user)
 	return FALSE;
 }
 =

-static void reachable_cb(GIsiClient *client, bool alive, uint16_t object,
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
 				void *opaque)
 {
 	struct ofono_netreg *netreg =3D opaque;
diff --git a/drivers/isimodem/phonebook.c b/drivers/isimodem/phonebook.c
index 16f9a19..9151111 100644
--- a/drivers/isimodem/phonebook.c
+++ b/drivers/isimodem/phonebook.c
@@ -68,7 +68,7 @@ static int decode_read_response(const unsigned char *msg,=
 size_t len,
 	if (msg[1] !=3D SIM_PB_READ)
 		goto error;
 =

-	for (g_isi_sb_iter_init_full(&iter, msg, len, 3, true, msg[2]);
+	for (g_isi_sb_iter_init_full(&iter, msg, len, 3, TRUE, msg[2]);
 	     g_isi_sb_iter_is_valid(&iter);
 	     g_isi_sb_iter_next(&iter)) {
 =

@@ -206,8 +206,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool read_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean read_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -222,7 +223,7 @@ static bool read_resp_cb(GIsiClient *client, const void=
 *restrict data,
 	location =3D decode_read_response(data, len, cbd->user);
 	if (location !=3D -1) {
 		read_next_entry(client, location, read_resp_cb, cbd);
-		return true;
+		return TRUE;
 	}
 =

 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
@@ -233,7 +234,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_export_entries(struct ofono_phonebook *pb, const char *sto=
rage,
@@ -286,7 +287,7 @@ static gboolean isi_phonebook_register(gpointer user)
 	return FALSE;
 }
 =

-static void reachable_cb(GIsiClient *client, bool alive, uint16_t object,
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
 				void *opaque)
 {
 	struct ofono_phonebook *pb =3D opaque;
diff --git a/drivers/isimodem/radio-settings.c b/drivers/isimodem/radio-set=
tings.c
index fe1e0db..f1b7632 100644
--- a/drivers/isimodem/radio-settings.c
+++ b/drivers/isimodem/radio-settings.c
@@ -76,8 +76,9 @@ static int ofono_mode_to_isi_mode(enum ofono_radio_access=
_mode mode)
 	}
 }
 =

-static bool rat_mode_read_resp_cb(GIsiClient *client, const void *restrict=
 data,
-					size_t len, uint16_t object,
+static gboolean rat_mode_read_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object,
 					void *opaque)
 {
 	const unsigned char *msg =3D data;
@@ -92,7 +93,7 @@ static bool rat_mode_read_resp_cb(GIsiClient *client, con=
st void *restrict data,
 =

 	if (len < 3) {
 		DBG("truncated message");
-		return false;
+		return FALSE;
 	}
 =

 	if (msg[0] =3D=3D GSS_CS_SERVICE_FAIL_RESP)
@@ -130,14 +131,14 @@ static bool rat_mode_read_resp_cb(GIsiClient *client,=
 const void *restrict data,
 		goto out;
 	}
 =

-	return false;
+	return FALSE;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_query_rat_mode(struct ofono_radio_settings *rs,
@@ -165,8 +166,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool mode_write_resp_cb(GIsiClient *client, const void *restrict da=
ta,
-				size_t len, uint16_t object, void *opaque)
+static gboolean mode_write_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -179,7 +181,7 @@ static bool mode_write_resp_cb(GIsiClient *client, cons=
t void *restrict data,
 =

 	if (len < 3) {
 		DBG("truncated message");
-		return false;
+		return FALSE;
 	}
 =

 	if (msg[0] =3D=3D GSS_CS_SERVICE_FAIL_RESP)
@@ -190,14 +192,14 @@ static bool mode_write_resp_cb(GIsiClient *client, co=
nst void *restrict data,
 		goto out;
 	}
 =

-	return false;
+	return FALSE;
 =

 error:
 	CALLBACK_WITH_FAILURE(cb, cbd->data);
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_set_rat_mode(struct ofono_radio_settings *rs,
@@ -250,7 +252,7 @@ static gboolean isi_radio_settings_register(gpointer us=
er)
 	return FALSE;
 }
 =

-static void reachable_cb(GIsiClient *client, bool alive, uint16_t object,
+static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
 				void *opaque)
 {
 	struct ofono_radio_settings *rs =3D opaque;
diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index eb88811..e2ea275 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -45,7 +45,7 @@
 =

 struct sim_data {
 	GIsiClient *client;
-	bool registered;
+	gboolean registered;
 };
 =

 struct file_info {
@@ -94,8 +94,9 @@ static void isi_read_file_info(struct ofono_sim *sim, int=
 fileid,
 	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, data);
 }
 =

-static bool spn_resp_cb(GIsiClient *client, const void *restrict data,
-			size_t len, uint16_t object, void *opaque)
+static gboolean spn_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -111,7 +112,7 @@ static bool spn_resp_cb(GIsiClient *client, const void =
*restrict data,
 =

 	if (len < 39 || msg[0] !=3D SIM_SERV_PROV_NAME_RESP
 		|| msg[1] !=3D SIM_ST_READ_SERV_PROV_NAME)
-		return false;
+		return FALSE;
 =

 	if (msg[2] !=3D SIM_SERV_OK) {
 		DBG("Request failed: %s (0x%02X)",
@@ -141,10 +142,10 @@ done:
 		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
 =

 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

-static bool isi_read_spn(struct ofono_sim *sim, struct isi_cb_data *cbd)
+static gboolean isi_read_spn(struct ofono_sim *sim, struct isi_cb_data *cb=
d)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

@@ -158,8 +159,9 @@ static bool isi_read_spn(struct ofono_sim *sim, struct =
isi_cb_data *cbd)
 					SIM_TIMEOUT, spn_resp_cb, cbd) !=3D NULL;
 }
 =

-static bool read_iccid_resp_cb(GIsiClient *client, const void *restrict da=
ta,
-				size_t len, uint16_t object, void *user)
+static gboolean read_iccid_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *user)
 {
 	struct isi_cb_data *cbd =3D user;
 	ofono_sim_read_cb_t cb =3D cbd->cb;
@@ -172,7 +174,7 @@ static bool read_iccid_resp_cb(GIsiClient *client, cons=
t void *restrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D SIM_READ_FIELD_RESP || msg[1] !=3D ICC)
-		return false;
+		return FALSE;
 =

 	if (msg[2] =3D=3D SIM_SERV_OK && len >=3D 13)
 		iccid =3D msg + 3;
@@ -186,10 +188,10 @@ done:
 		CALLBACK_WITH_FAILURE(cb, NULL, 0, cbd->data);
 =

 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

-static bool isi_read_iccid(struct ofono_sim *sim, struct isi_cb_data *cbd)
+static gboolean isi_read_iccid(struct ofono_sim *sim, struct isi_cb_data *=
cbd)
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	const unsigned char req[] =3D { SIM_READ_FIELD_REQ, ICC };
@@ -269,8 +271,9 @@ static void isi_write_file_cyclic(struct ofono_sim *sim=
, int fileid,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static bool imsi_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean imsi_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -320,7 +323,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_read_imsi(struct ofono_sim *sim,
@@ -351,30 +354,31 @@ static void isi_sim_register(struct ofono_sim *sim)
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 =

 	if (!sd->registered) {
-		sd->registered =3D true;
+		sd->registered =3D TRUE;
 		ofono_sim_register(sim);
 		ofono_sim_inserted_notify(sim, TRUE);
 	}
 }
 =

-static bool read_hplmn_resp_cb(GIsiClient *client, const void *restrict da=
ta,
-				size_t len, uint16_t object, void *opaque)
+static gboolean read_hplmn_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct ofono_sim *sim =3D opaque;
 =

 	if (!msg) {
 		DBG("ISI client error: %d", g_isi_client_error(client));
-		return true;
+		return TRUE;
 	}
 =

 	if (len < 3 || msg[0] !=3D SIM_NETWORK_INFO_RESP || msg[1] !=3D READ_HPLM=
N)
-		return false;
+		return FALSE;
 =

 	if (msg[2] !=3D SIM_SERV_NOTREADY)
 		isi_sim_register(sim);
 =

-	return true;
+	return TRUE;
 }
 =

 =

@@ -391,8 +395,9 @@ static void isi_read_hplmn(struct ofono_sim *sim)
 				read_hplmn_resp_cb, sim);
 }
 =

-static void sim_ind_cb(GIsiClient *client, const void *restrict data,
-			size_t len, uint16_t object, void *opaque)
+static void sim_ind_cb(GIsiClient *client,
+			const void *restrict data, size_t len,
+			uint16_t object, void *opaque)
 {
 	struct ofono_sim *sim =3D opaque;
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
@@ -411,7 +416,7 @@ static void sim_ind_cb(GIsiClient *client, const void *=
restrict data,
 	}
 }
 =

-static void sim_reachable_cb(GIsiClient *client, bool alive,
+static void sim_reachable_cb(GIsiClient *client, gboolean alive,
 				uint16_t object, void *opaque)
 {
 	struct ofono_sim *sim =3D opaque;
diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 768d38b..1d69dbb 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -51,8 +51,9 @@ struct sms_data {
 	GIsiClient *sim;
 };
 =

-static bool sca_query_resp_cb(GIsiClient *client, const void *restrict dat=
a,
-				size_t len, uint16_t object, void *opaque)
+static gboolean sca_query_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const uint8_t *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -68,7 +69,7 @@ static bool sca_query_resp_cb(GIsiClient *client, const v=
oid *restrict data,
 	}
 =

 	if (len < 31 || msg[0] !=3D SIM_SMS_RESP || msg[1] !=3D READ_PARAMETER)
-		return false;
+		return FALSE;
 =

 	if (msg[3] !=3D SIM_SERV_OK)
 		goto error;
@@ -95,7 +96,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_sca_query(struct ofono_sms *sms,
@@ -122,8 +123,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool sca_set_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean sca_set_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const uint8_t *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -135,7 +137,7 @@ static bool sca_set_resp_cb(GIsiClient *client, const v=
oid *restrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D SIM_SMS_RESP || msg[1] !=3D UPDATE_PARAMETER)
-		return false;
+		return FALSE;
 =

 	if (msg[2] !=3D SIM_SERV_OK)
 		goto error;
@@ -148,7 +150,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_sca_set(struct ofono_sms *sms,
@@ -191,8 +193,9 @@ error:
 	g_free(cbd);
 }
 =

-static bool submit_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean submit_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const uint8_t *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -207,7 +210,7 @@ static bool submit_resp_cb(GIsiClient *client, const vo=
id *restrict data,
 	}
 =

 	if (len < 3 || msg[0] !=3D SMS_MESSAGE_SEND_RESP)
-		return false;
+		return FALSE;
 =

 	for (g_isi_sb_iter_init(&iter, msg, len, 3);
 		g_isi_sb_iter_is_valid(&iter);
@@ -257,7 +260,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static void isi_submit(struct ofono_sms *sms, unsigned char *pdu,
@@ -322,8 +325,9 @@ error:
 	g_free(cbd);
 }
 =

-static void send_status_ind_cb(GIsiClient *client, const void *restrict da=
ta,
-				size_t len, uint16_t object, void *opaque)
+static void send_status_ind_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const uint8_t *msg =3D data;
 =

@@ -337,24 +341,25 @@ static void send_status_ind_cb(GIsiClient *client, co=
nst void *restrict data,
 	DBG("TODO: Status notification");
 }
 =

-static bool report_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean report_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const uint8_t *msg =3D data;
 =

 	if (!msg) {
 		DBG("ISI client error: %d", g_isi_client_error(client));
-		return true;
+		return TRUE;
 	}
 =

 	if (len < 3 || msg[0] !=3D SMS_GSM_RECEIVED_PP_REPORT_RESP)
-		return false;
+		return FALSE;
 =

 	DBG("Report resp cause=3D0x%"PRIx8, msg[1]);
-	return true;
+	return TRUE;
 }
 =

-static bool send_deliver_report(GIsiClient *client, bool success)
+static gboolean send_deliver_report(GIsiClient *client, gboolean success)
 {
 	uint8_t cause_type =3D !success ? SMS_CAUSE_TYPE_GSM : 0;
 	uint8_t cause =3D !success ? SMS_GSM_ERR_MEMORY_CAPACITY_EXC : 0;
@@ -374,11 +379,12 @@ static bool send_deliver_report(GIsiClient *client, b=
ool success)
 	};
 =

 	return g_isi_request_make(client, msg, sizeof(msg), SMS_TIMEOUT,
-					report_resp_cb, NULL);
+					report_resp_cb, NULL) !=3D NULL;
 }
 =

-static void routing_ntf_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static void routing_ntf_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const uint8_t *msg =3D data;
 	struct ofono_sms *sms =3D opaque;
@@ -446,11 +452,12 @@ static void routing_ntf_cb(GIsiClient *client, const =
void *restrict data,
 	 * reliably stored, i.e., written to disk. Currently, there is
 	 * no such indication from core, so we just blindly trust that
 	 * it did The Right Thing here. */
-	send_deliver_report(client, true);
+	send_deliver_report(client, TRUE);
 }
 =

-static bool routing_resp_cb(GIsiClient *client, const void *restrict data,
-				size_t len, uint16_t object, void *opaque)
+static gboolean routing_resp_cb(GIsiClient *client,
+				const void *restrict data, size_t len,
+				uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct ofono_sms *sms =3D opaque;
@@ -476,17 +483,17 @@ static bool routing_resp_cb(GIsiClient *client, const=
 void *restrict data,
 				msg[1], sms_isi_cause_name(msg[1]));
 			ofono_sms_register(sms);
 		}
-		return true;
+		return TRUE;
 	}
 =

 	g_isi_subscribe(client, SMS_PP_ROUTING_NTF, routing_ntf_cb, sms);
 =

 	ofono_sms_register(sms);
-	return true;
+	return TRUE;
 =

 error:
 	DBG("Unable to bootstrap SMS routing.");
-	return true;
+	return TRUE;
 }
 =

 static int isi_sms_probe(struct ofono_sms *sms, unsigned int vendor,
diff --git a/drivers/isimodem/ussd.c b/drivers/isimodem/ussd.c
index a8bbace..8be20b6 100644
--- a/drivers/isimodem/ussd.c
+++ b/drivers/isimodem/ussd.c
@@ -118,8 +118,9 @@ out:
 }
 =

 =

-static bool ussd_send_resp_cb(GIsiClient *client, const void *restrict dat=
a,
-				size_t len, uint16_t object, void *opaque)
+static gboolean ussd_send_resp_cb(GIsiClient *client,
+					const void *restrict data, size_t len,
+					uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct isi_cb_data *cbd =3D opaque;
@@ -131,13 +132,13 @@ static bool ussd_send_resp_cb(GIsiClient *client, con=
st void *restrict data,
 	}
 =

 	if (len < 3)
-		return false;
+		return FALSE;
 =

 	if (msg[0] =3D=3D SS_SERVICE_FAILED_RESP)
 		goto error;
 =

 	if (len < 4 || msg[0] !=3D SS_GSM_USSD_SEND_RESP)
-		return false;
+		return FALSE;
 =

 	CALLBACK_WITH_SUCCESS(cb, cbd->data);
 =

@@ -149,7 +150,7 @@ error:
 =

 out:
 	g_free(cbd);
-	return true;
+	return TRUE;
 }
 =

 static GIsiRequest *ussd_send_make(GIsiClient *client, uint8_t *str,
@@ -233,8 +234,9 @@ error:
 	g_free(cbd);
 }
 =

-static void ussd_ind_cb(GIsiClient *client, const void *restrict data,
-			size_t len, uint16_t object, void *opaque)
+static void ussd_ind_cb(GIsiClient *client,
+			const void *restrict data, size_t len,
+			uint16_t object, void *opaque)
 {
 	const unsigned char *msg =3D data;
 	struct ofono_ussd *ussd =3D opaque;
@@ -261,7 +263,8 @@ static gboolean isi_ussd_register(gpointer user)
 	return FALSE;
 }
 =

-static void ussd_reachable_cb(GIsiClient *client, bool alive, uint16_t obj=
ect,
+static void ussd_reachable_cb(GIsiClient *client,
+				gboolean alive, uint16_t object,
 				void *opaque)
 {
 	struct ofono_ussd *ussd =3D opaque;
diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 90106ee..44ffe96 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -75,12 +75,12 @@ typedef void GIsiIndication (GIsiClient *client,
 		const void *restrict data, size_t len,
 		uint16_t object, void *opaque);
 =

-typedef void GIsiVerify (GIsiClient *client, bool alive, uint16_t object,
+typedef void GIsiVerify(GIsiClient *client, gboolean alive, uint16_t objec=
t,
 				void *opaque);
 =

-typedef bool GIsiResponse(GIsiClient *client,
-			  void const * restrict data, size_t len,
-			  uint16_t object, void *opaque);
+typedef gboolean GIsiResponse(GIsiClient *client,
+				void const *restrict data, size_t len,
+				uint16_t object, void *opaque);
 =

 static GIsiVerify isi_call_verify_cb;
 static gboolean isi_call_register(gpointer);
@@ -171,12 +171,12 @@ static void isi_ctx_free(struct isi_call_req_context =
*irc)
 	}
 }
 =

-static bool isi_ctx_return(struct isi_call_req_context *irc,
-			   enum ofono_error_type type,
-			   int error)
+static gboolean isi_ctx_return(struct isi_call_req_context *irc,
+				enum ofono_error_type type,
+				int error)
 {
 	if (!irc)
-		return true;
+		return TRUE;
 =

 	if (irc->cb) {
 		struct ofono_error e =3D { .type =3D type, .error =3D error };
@@ -185,19 +185,19 @@ static bool isi_ctx_return(struct isi_call_req_contex=
t *irc,
 =

 	isi_ctx_free(irc);
 =

-	return true;
+	return TRUE;
 }
 =

-static bool isi_ctx_return_failure(struct isi_call_req_context *irc)
+static gboolean isi_ctx_return_failure(struct isi_call_req_context *irc)
 {
 	return isi_ctx_return(irc, OFONO_ERROR_TYPE_FAILURE, 0);
 }
 =

-static bool isi_ctx_return_success(struct isi_call_req_context *irc)
+static gboolean isi_ctx_return_success(struct isi_call_req_context *irc)
 {
 	if (irc && irc->step) {
 		irc->step(irc, 0);
-		return true;
+		return TRUE;
 	}
 =

 	return isi_ctx_return(irc, OFONO_ERROR_TYPE_NO_ERROR, 0);
@@ -408,22 +408,22 @@ isi_call_create_req(struct ofono_voicecall *ovc,
 	return isi_call_req(ovc, req, rlen, isi_call_create_resp, cb, data);
 }
 =

-static bool isi_call_create_resp(GIsiClient *client,
-				 void const * restrict data,
-				 size_t len,
-				 uint16_t object,
-				 void *irc)
+static gboolean isi_call_create_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
 {
 	struct {
 		uint8_t message_id, call_id, sub_blocks;
 	} const *m =3D data;
 =

 	if (m !=3D NULL && len < (sizeof *m))
-		return false;
+		return FALSE;
 	if (m =3D=3D NULL || m->message_id =3D=3D CALL_COMMON_MESSAGE)
 		return isi_ctx_return_failure(irc);
 	if (m->message_id !=3D CALL_CREATE_RESP)
-		return false;
+		return FALSE;
 =

 	if (m->call_id !=3D CALL_ID_NONE && m->sub_blocks =3D=3D 0)
 		return isi_ctx_return_success(irc);
@@ -518,22 +518,22 @@ isi_call_answer_req(struct ofono_voicecall *ovc,
 	return isi_call_req(ovc, req, rlen, isi_call_answer_resp, cb, data);
 }
 =

-static bool isi_call_answer_resp(GIsiClient *client,
-				 void const * restrict data,
-				 size_t len,
-				 uint16_t object,
-				 void *irc)
+static gboolean isi_call_answer_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
 {
 	struct {
 		uint8_t message_id, call_id, sub_blocks;
 	} const *m =3D data;
 =

 	if (m !=3D NULL && len < (sizeof *m))
-		return false;
+		return FALSE;
 	if (m =3D=3D NULL || m->message_id =3D=3D CALL_COMMON_MESSAGE)
 		return isi_ctx_return_failure(irc);
 	if (m->message_id !=3D CALL_ANSWER_RESP)
-		return false;
+		return FALSE;
 =

 	if (m->call_id !=3D CALL_ID_NONE && m->sub_blocks =3D=3D 0)
 		return isi_ctx_return_success(irc);
@@ -559,11 +559,11 @@ isi_call_release_req(struct ofono_voicecall *ovc,
 	return isi_call_req(ovc, req, rlen, isi_call_release_resp, cb, data);
 }
 =

-static bool isi_call_release_resp(GIsiClient *client,
-				     void const * restrict data,
-				     size_t len,
-				     uint16_t object,
-				     void *irc)
+static gboolean isi_call_release_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
 {
 	struct {
 		uint8_t message_id, call_id, sub_blocks;
@@ -572,11 +572,11 @@ static bool isi_call_release_resp(GIsiClient *client,
 	uint8_t cause_type =3D 0, cause =3D 0;
 =

 	if (m !=3D NULL && len < (sizeof *m))
-		return false;
+		return FALSE;
 	if (m =3D=3D NULL || m->message_id =3D=3D CALL_COMMON_MESSAGE)
 		return isi_ctx_return_failure(irc);
 	if (m->message_id !=3D CALL_RELEASE_RESP)
-		return false;
+		return FALSE;
 =

 	for (g_isi_sb_iter_init(i, m, len, (sizeof *m));
 	     g_isi_sb_iter_is_valid(i);
@@ -613,11 +613,11 @@ isi_call_status_req(struct ofono_voicecall *ovc,
 }
 =

 =

-static bool isi_call_status_resp(GIsiClient *client,
-				 void const * restrict data,
-				 size_t len,
-				 uint16_t object,
-				 void *_irc)
+static gboolean isi_call_status_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *_irc)
 {
 	struct isi_call_req_context *irc =3D _irc;
 	struct ofono_voicecall *ovc =3D irc->ovc;
@@ -629,11 +629,11 @@ static bool isi_call_status_resp(GIsiClient *client,
 	struct isi_call *call =3D NULL;
 =

 	if (m !=3D NULL && len < (sizeof *m))
-		return false;
+		return FALSE;
 	if (m =3D=3D NULL || m->message_id =3D=3D CALL_COMMON_MESSAGE)
 		return isi_ctx_return_failure(irc);
 	if (m->message_id !=3D CALL_STATUS_RESP)
-		return false;
+		return FALSE;
 =

 	for (g_isi_sb_iter_init(sb, m, len, (sizeof *m));
 	     g_isi_sb_iter_is_valid(sb);
@@ -701,7 +701,7 @@ isi_call_deflect_req(struct ofono_voicecall *ovc,
 =

 	if (addr_len > 20) {
 		CALLBACK_WITH_FAILURE(cb, data);
-		return false;
+		return FALSE;
 	}
 =

 	for (i =3D 0; i < addr_len; i++)
@@ -710,11 +710,11 @@ isi_call_deflect_req(struct ofono_voicecall *ovc,
 	return isi_call_req(ovc, req, rlen, isi_call_control_resp, cb, data);
 }
 =

-static bool isi_call_control_resp(GIsiClient *client,
-				  void const * restrict data,
-				  size_t len,
-				  uint16_t object,
-				  void *irc)
+static gboolean isi_call_control_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
 {
 	struct {
 		uint8_t message_id, call_id, sub_blocks;
@@ -723,11 +723,11 @@ static bool isi_call_control_resp(GIsiClient *client,
 	uint8_t cause_type =3D 0, cause =3D 0;
 =

 	if (m !=3D NULL && len < sizeof *m)
-		return false;
+		return FALSE;
 	if (m =3D=3D NULL || m->message_id =3D=3D CALL_COMMON_MESSAGE)
 		return isi_ctx_return_failure(irc);
 	if (m->message_id !=3D CALL_CONTROL_RESP)
-		return false;
+		return FALSE;
 =

 	for (g_isi_sb_iter_init(i, m, len, (sizeof *m));
 	     g_isi_sb_iter_is_valid(i);
@@ -770,7 +770,7 @@ isi_call_dtmf_send_req(struct ofono_voicecall *ovc,
 =

 	if (sub_len >=3D 256) {
 		CALLBACK_WITH_FAILURE(cb, data);
-		return false;
+		return FALSE;
 	}
 =

 	for (i =3D 0; i < str_len; i++)
@@ -779,11 +779,11 @@ isi_call_dtmf_send_req(struct ofono_voicecall *ovc,
 	return isi_call_req(ovc, req, rlen, isi_call_dtmf_send_resp, cb, data);
 }
 =

-static bool isi_call_dtmf_send_resp(GIsiClient *client,
-				    void const * restrict data,
-				    size_t len,
-				    uint16_t object,
-				    void *irc)
+static gboolean isi_call_dtmf_send_resp(GIsiClient *client,
+					void const *restrict data,
+					size_t len,
+					uint16_t object,
+					void *irc)
 {
 	struct {
 		uint8_t message_id, call_id, sub_blocks;
@@ -792,11 +792,11 @@ static bool isi_call_dtmf_send_resp(GIsiClient *clien=
t,
 	uint8_t cause_type =3D 0, cause =3D 0;
 =

 	if (m !=3D NULL && len < (sizeof *m))
-		return false;
+		return FALSE;
 	if (m =3D=3D NULL || m->message_id =3D=3D CALL_COMMON_MESSAGE)
 		return isi_ctx_return_failure(irc);
 	if (m->message_id !=3D CALL_DTMF_SEND_RESP)
-		return false;
+		return FALSE;
 =

 	if (m->sub_blocks =3D=3D 0)
 		return isi_ctx_return_success(irc);
@@ -1302,7 +1302,7 @@ static int isi_voicecall_probe(struct ofono_voicecall=
 *ovc,
 }
 =

 static void isi_call_verify_cb(GIsiClient *client,
-			       bool alive, uint16_t object,
+			       gboolean alive, uint16_t object,
 			       void *ovc)
 {
 	if (!alive) {
-- =

1.6.3.3


--===============2576758749647271885==--

