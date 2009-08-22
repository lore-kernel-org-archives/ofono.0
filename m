Content-Type: multipart/mixed; boundary="===============8529272043604805232=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Read messages left over in ME storage on startup.
Date: Sat, 22 Aug 2009 04:35:24 +0200
Message-ID: <1250908524-10518-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8529272043604805232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On modems that don't support +CMT (or for class 2 SMSes) the messages are
stored in the modem and then read and deleted from there in two separate
steps with no warranty that deletion succeeds or (more likely) power is
cut before the deletion happens.  Over time the memory may become full
and if we don't want to deal with this condition we need to check on
startup if there are messages we haven't deleted.

We can't differentiate between those messages and those the user already
had on the SIM / modem before installing ofono or switching phones, so we
might want to deliver messages with REC READ status with some kind of
indication that these are potentially old so the UI doesn't emit spurious
alerts.  We don't do this now and just deliver as usual.
---
 drivers/atmodem/sms.c |  128 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 128 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 39cc718..ce78e9a 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -47,10 +47,12 @@ static const char *cmgf_prefix[] =3D { "+CMGF:", NULL };
 static const char *cpms_prefix[] =3D { "+CPMS:", NULL };
 static const char *cnmi_prefix[] =3D { "+CNMI:", NULL };
 static const char *cmgs_prefix[] =3D { "+CMGS:", NULL };
+static const char *cmgl_prefix[] =3D { "+CMGL:", NULL };
 static const char *none_prefix[] =3D { NULL };
 =

 static gboolean set_cmgf(gpointer user_data);
 static gboolean set_cpms(gpointer user_data);
+static void at_cmgl_set_cpms(struct ofono_modem *modem, int store);
 =

 #define MAX_CMGF_RETRIES 10
 #define MAX_CPMS_RETRIES 10
@@ -515,6 +517,126 @@ err:
 	ofono_error("Unable to parse CMTI notification");
 }
 =

+static void at_cmgl_done(struct ofono_modem *modem)
+{
+	struct at_data *at =3D ofono_modem_get_userdata(modem);
+
+	if (at->sms->incoming =3D=3D MT_STORE &&
+			at->sms->store =3D=3D ME_STORE)
+		at_cmgl_set_cpms(modem, SM_STORE);
+}
+
+static void at_cmgl_cb(gboolean ok, GAtResult *result, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct at_data *at =3D ofono_modem_get_userdata(modem);
+	GAtResultIter iter;
+	const char *hexpdu;
+	unsigned char pdu[164];
+	long pdu_len;
+	int tpdu_len;
+	int index;
+	int status;
+	char buf[16];
+
+	dump_response("at_cmgl_cb", ok, result);
+
+	if (!ok) {
+		ofono_error("Initial listing SMS storage failed!");
+		goto err;
+	}
+
+	g_at_result_iter_init(&iter, result);
+
+	while (g_at_result_iter_next(&iter, "+CMGL:")) {
+		if (!g_at_result_iter_next_number(&iter, &index)) {
+			ofono_error("Unable to parse CMGL response");
+			goto err;
+		}
+
+		if (!g_at_result_iter_next_number(&iter, &status)) {
+			ofono_error("Unable to parse CMGL response");
+			goto err;
+		}
+
+		if (!g_at_result_iter_skip_next(&iter)) {
+			ofono_error("Unable to parse CMGL response");
+			goto err;
+		}
+
+		if (!g_at_result_iter_next_number(&iter, &tpdu_len)) {
+			ofono_error("Unable to parse CMGL response");
+			goto err;
+		}
+
+		/* Only MT messages */
+		if (status !=3D 0 && status !=3D 1)
+			continue;
+
+		hexpdu =3D g_at_result_pdu(result);
+
+		ofono_debug("Found an old SMS PDU: %s, with len: %d",
+				hexpdu, tpdu_len);
+
+		decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
+		ofono_sms_deliver_notify(modem, pdu, pdu_len, tpdu_len);
+
+		/* We don't buffer SMS on the SIM/ME, send along a CMGD */
+		sprintf(buf, "AT+CMGD=3D%d", index);
+		g_at_chat_send(at->parser, buf, none_prefix,
+				at_cmgd_cb, NULL, NULL);
+	}
+
+err:
+	at_cmgl_done(modem);
+}
+
+static void at_cmgl_cpms_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
+{
+	struct cpms_request *req =3D user_data;
+	struct ofono_modem *modem =3D req->modem;
+	struct at_data *at =3D ofono_modem_get_userdata(modem);
+
+	if (!ok) {
+		ofono_error("Initial CPMS request failed");
+		at_cmgl_done(modem);
+		return;
+	}
+
+	at->sms->store =3D req->store;
+
+	g_at_chat_send(at->parser, "AT+CMGL=3D4", cmgl_prefix,
+			at_cmgl_cb, modem, NULL);
+}
+
+static void at_cmgl_set_cpms(struct ofono_modem *modem, int store)
+{
+	struct at_data *at =3D ofono_modem_get_userdata(modem);
+
+	if (store =3D=3D at->sms->store) {
+		struct cpms_request req;
+
+		req.modem =3D modem;
+		req.store =3D store;
+
+		at_cmgl_cpms_cb(TRUE, NULL, &req);
+	} else {
+		char buf[128];
+		const char *readwrite =3D storages[store];
+		const char *incoming =3D storages[at->sms->incoming];
+		struct cpms_request *req =3D g_new(struct cpms_request, 1);
+
+		req->modem =3D modem;
+		req->store =3D store;
+
+		sprintf(buf, "AT+CPMS=3D\"%s\",\"%s\",\"%s\"",
+			readwrite, readwrite, incoming);
+
+		g_at_chat_send(at->parser, buf, cpms_prefix, at_cmgl_cpms_cb,
+				req, g_free);
+	}
+}
+
 static void at_sms_initialized(struct ofono_modem *modem)
 {
 	struct at_data *at =3D ofono_modem_get_userdata(modem);
@@ -533,6 +655,12 @@ static void at_sms_initialized(struct ofono_modem *mod=
em)
 				modem, NULL);
 =

 	ofono_sms_manager_register(modem, &ops);
+
+	/* Inspect and free the incoming SMS storage */
+	if (at->sms->incoming =3D=3D MT_STORE)
+		at_cmgl_set_cpms(modem, ME_STORE);
+	else
+		at_cmgl_set_cpms(modem, at->sms->incoming);
 }
 =

 static void at_sms_not_supported(struct ofono_modem *modem)
-- =

1.6.1


--===============8529272043604805232==--

