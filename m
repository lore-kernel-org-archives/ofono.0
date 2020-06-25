Content-Type: multipart/mixed; boundary="===============2552069396595672402=="
MIME-Version: 1.0
From: Jimmy Gysens <jimmy.gysens_ext@softathome.com>
Subject: [PATCH 2/2] huawei: add ^REJINFO unsolicited listener
Date: Thu, 25 Jun 2020 11:28:25 +0200
Message-ID: <20200625092825.4475-2-jimmy.gysens_ext@softathome.com>
In-Reply-To: <20200625092825.4475-1-jimmy.gysens_ext@softathome.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2552069396595672402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add an event listener for Huawei's ^REJINFO unsolicited event.
This event provides information regarding the network's attach state.

Format:

^REJINFO:<PLMN ID>,<Service Domain>,<Reject Cause>,<Rat Type>,<Reject Type>

Note: not all Huawei devices support this.

Reference: Huawei ME909s Series LTE Module V100R001 AT command
specification.
---
 drivers/atmodem/gprs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index b637f733..58d4eed3 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -484,6 +484,36 @@ static void huawei_mode_notify(GAtResult *result, gpoi=
nter user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

+static void huawei_rejinfo_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	GAtResultIter iter;
+	int plmn, service_domain, reject_cause, rat_type, reject_type;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^REJINFO:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &plmn))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &service_domain))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &reject_cause))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &rat_type))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &reject_type))
+		return;
+
+	ofono_gprs_rejectinfo_notify(gprs, plmn, service_domain,
+					rat_type, reject_cause, reject_type);
+}
+
 static void huawei_hcsq_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -611,6 +641,8 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 						FALSE, gprs, NULL);
 		g_at_chat_register(gd->chat, "^HCSQ:", huawei_hcsq_notify,
 						FALSE, gprs, NULL);
+		g_at_chat_register(gd->chat, "^REJINFO:", huawei_rejinfo_notify,
+						FALSE, gprs, NULL);
 		break;
 	case OFONO_VENDOR_UBLOX:
 		g_at_chat_register(gd->chat, "+UREG:", ublox_ureg_notify,
-- =

2.17.1

--===============2552069396595672402==--

