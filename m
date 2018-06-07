Content-Type: multipart/mixed; boundary="===============8085134895444482184=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] cbs: ETWS and cmas support for intel lte modem
Date: Thu, 07 Jun 2018 15:56:32 +0530
Message-ID: <1528367192-26066-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8085134895444482184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Antara <antara.borwankar@intel.com>

handling of intel propriotery AT commands in atdriver for
intel modems.

Signed-off-by: Antara <antara.borwankar@intel.com>
---
 drivers/atmodem/cbs.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
index 3c491be..ef1e9c4 100644
--- a/drivers/atmodem/cbs.c
+++ b/drivers/atmodem/cbs.c
@@ -48,6 +48,51 @@ struct cbs_data {
 	unsigned int vendor;
 };
 =

+static void at_xmm_etw_sec_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_cbs *cbs =3D user_data;
+	const char *hexpdu;
+	int pdulen;
+	GAtResultIter iter;
+	unsigned char pdu[88];
+	long hexpdulen;
+
+	DBG("");
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+XETWSECWARN:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &pdulen))
+		return;
+
+	if (pdulen !=3D 88) {
+		ofono_error("Got a CBM message with invalid PDU size!");
+		return;
+	}
+
+	hexpdu =3D g_at_result_pdu(result);
+	if (hexpdu =3D=3D NULL) {
+		ofono_error("Got a CBM, but no PDU.  Are we in text mode?");
+		return;
+	}
+
+	DBG("Got new Cell Broadcast via CBM: %s, %d", hexpdu, pdulen);
+
+	if (decode_hex_own_buf(hexpdu, -1, &hexpdulen, 0, pdu) =3D=3D NULL) {
+		ofono_error("Unable to hex-decode the PDU");
+		return;
+	}
+
+	if (hexpdulen !=3D pdulen) {
+		ofono_error("hexpdu length not equal to reported pdu length");
+		return;
+	}
+
+	ofono_cbs_notify(cbs, pdu, pdulen);
+}
+
 static void at_cbm_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_cbs *cbs =3D user_data;
@@ -124,6 +169,10 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs, c=
onst char *topics,
 		g_at_chat_send(data->chat, "AT+CSCB=3D0", none_prefix,
 				NULL, NULL, NULL);
 		break;
+	case OFONO_VENDOR_XMM:
+		g_at_chat_send(data->chat, "AT+XETWNTFYSTART=3D2", none_prefix,
+				NULL, NULL, NULL);
+		break;
 	default:
 		break;
 	}
@@ -151,6 +200,10 @@ static void at_cbs_clear_topics(struct ofono_cbs *cbs,
 =

 	DBG("");
 =

+	if(data->vendor =3D=3D OFONO_VENDOR_XMM)
+                g_at_chat_send(data->chat, "AT+XETWNTFYSTOP=3D2", none_pre=
fix,
+                                NULL, NULL, NULL);
+
 	if (g_at_chat_send(data->chat, "AT+CSCB=3D0", none_prefix,
 				at_cscb_set_cb, cbd, g_free) > 0)
 		return;
@@ -175,6 +228,10 @@ static void at_cbs_register(gboolean ok, GAtResult *re=
sult, gpointer user)
 	 */
 	g_at_chat_register(data->chat, "+CBM:", at_cbm_notify, TRUE, cbs, NULL);
 =

+	if(data->vendor =3D=3D OFONO_VENDOR_XMM) {
+		g_at_chat_register(data->chat, "+XETWSECWARN:", at_xmm_etw_sec_notify, T=
RUE, cbs, NULL);
+	}
+
 	ofono_cbs_register(cbs);
 }
 =

@@ -223,6 +280,13 @@ static int at_cbs_probe(struct ofono_cbs *cbs, unsigne=
d int vendor,
 =

 	ofono_cbs_set_data(cbs, data);
 =

+	if(vendor =3D=3D OFONO_VENDOR_XMM) {
+		g_at_chat_send(data->chat, "AT+XCMAS=3D1", cscb_prefix,
+				NULL, NULL, NULL);
+		g_at_chat_send(data->chat, "AT+XETWCFG=3D1,1,0,0; ", none_prefix,
+				NULL, NULL, NULL);
+	}
+
 	g_at_chat_send(data->chat, "AT+CSCB=3D?", cscb_prefix,
 			at_cscb_support_cb, cbs, NULL);
 =

-- =

1.9.1


--===============8085134895444482184==--

