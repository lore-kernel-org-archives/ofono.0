Content-Type: multipart/mixed; boundary="===============6198135732397051851=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [RfC][PATCH 1/3] stk: API for SMS Point-to-Point download to UICC
Date: Sun, 07 Nov 2010 18:42:18 +0100
Message-ID: <1289151740-9922-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6198135732397051851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The callback returns the TP-User-Data element content of the RP-ACK or
RP-ERROR message, returned by the UICC.
---
 src/ofono.h |    8 ++++++++
 src/stk.c   |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index ab6ecd2..e5b4acb 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -283,9 +283,17 @@ unsigned short __ofono_sms_get_next_ref(struct ofono_s=
ms *sms);
 #include <ofono/sim.h>
 #include <ofono/stk.h>
 =

+typedef void (*__ofono_sms_sim_download_cb_t)(ofono_bool_t ok,
+						const unsigned char *tp_ud,
+						int len, void *data);
+
 struct cbs;
 void __ofono_cbs_sim_download(struct ofono_stk *stk, const struct cbs *msg=
);
 =

+struct sms;
+int __ofono_sms_sim_download(struct ofono_stk *stk, const struct sms *msg,
+				__ofono_sms_sim_download_cb_t cb, void *data);
+
 #include <ofono/ssn.h>
 =

 typedef void (*ofono_ssn_mo_notify_cb)(int index, void *user);
diff --git a/src/stk.c b/src/stk.c
index 230c923..18beee6 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -75,6 +75,9 @@ struct ofono_stk {
 	struct stk_icon_id idle_mode_icon;
 	struct timeval get_inkey_start_ts;
 	int dtmf_id;
+
+	__ofono_sms_sim_download_cb_t sms_pp_cb;
+	void *sms_pp_userdata;
 };
 =

 struct envelope_op {
@@ -257,6 +260,42 @@ void __ofono_cbs_sim_download(struct ofono_stk *stk, c=
onst struct cbs *msg)
 		stk_cbs_download_cb(stk, FALSE, NULL, -1);
 }
 =

+static void stk_sms_download_cb(struct ofono_stk *stk, gboolean ok,
+				const unsigned char *data, int len)
+{
+	DBG("SMS-PP download to UICC reported %s", ok ? "success" : "error");
+
+	if (stk->sms_pp_cb)
+		stk->sms_pp_cb(ok, data, len, stk->sms_pp_userdata);
+}
+
+int __ofono_sms_sim_download(struct ofono_stk *stk, const struct sms *msg,
+				__ofono_sms_sim_download_cb_t cb, void *data)
+{
+	struct stk_envelope e;
+
+	if (msg->type !=3D SMS_TYPE_DELIVER)
+		return -EINVAL;
+
+	DBG("");
+
+	memset(&e, 0, sizeof(e));
+
+	e.type =3D STK_ENVELOPE_TYPE_SMS_PP_DOWNLOAD;
+	e.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
+
+	e.sms_pp_download.address.number =3D (char *) msg->sc_addr.address;
+	e.sms_pp_download.address.ton_npi =3D msg->sc_addr.numbering_plan |
+		(msg->sc_addr.number_type << 4);
+	memcpy(&e.sms_pp_download.message, &msg->deliver, sizeof(msg->deliver));
+
+	stk->sms_pp_cb =3D cb;
+	stk->sms_pp_userdata =3D data;
+
+	return stk_send_envelope(stk, &e, stk_sms_download_cb,
+					ENVELOPE_RETRIES_DEFAULT);
+}
+
 static char *dbus_apply_text_attributes(const char *text,
 					const struct stk_text_attribute *attr)
 {
-- =

1.7.1.86.g0e460.dirty


--===============6198135732397051851==--

