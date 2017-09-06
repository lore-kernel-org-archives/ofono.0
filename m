Content-Type: multipart/mixed; boundary="===============1436121685253936276=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 2/2] atmodem: correctly report lte bearer for huawei modems
Date: Wed, 06 Sep 2017 11:42:26 +0200
Message-ID: <1504690946-11705-3-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1504690946-11705-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1436121685253936276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gprs.c                 | 22 ++++++++++++++++++++++
 drivers/atmodem/network-registration.c | 25 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
index 94c7d05..df37d05 100644
--- a/drivers/atmodem/gprs.c
+++ b/drivers/atmodem/gprs.c
@@ -327,6 +327,26 @@ static void huawei_mode_notify(GAtResult *result, gpoi=
nter user_data)
 	ofono_gprs_bearer_notify(gprs, bearer);
 }
 =

+static void huawei_hcsq_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_gprs *gprs =3D user_data;
+	GAtResultIter iter;
+	const char *mode;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^HCSQ:"))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &mode))
+		return;
+
+	if (!strcmp("LTE", mode))
+		ofono_gprs_bearer_notify(gprs, 7); /* LTE */
+
+	/* in other modes, notification ^MODE is used */
+}
+
 static void telit_mode_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_gprs *gprs =3D user_data;
@@ -432,6 +452,8 @@ static void gprs_initialized(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	case OFONO_VENDOR_HUAWEI:
 		g_at_chat_register(gd->chat, "^MODE:", huawei_mode_notify,
 						FALSE, gprs, NULL);
+		g_at_chat_register(gd->chat, "^HCSQ:", huawei_hcsq_notify,
+						FALSE, gprs, NULL);
 		break;
 	case OFONO_VENDOR_UBLOX:
 	case OFONO_VENDOR_UBLOX_TOBY_L2:
diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index c2df0ce..a5e2af3 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1088,6 +1088,27 @@ static void huawei_mode_notify(GAtResult *result, gp=
ointer user_data)
 	}
 }
 =

+static void huawei_hcsq_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GAtResultIter iter;
+	const char *mode;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^HCSQ:"))
+		return;
+
+	if (!g_at_result_iter_next_string(&iter, &mode))
+		return;
+
+	if (!strcmp("LTE", mode))
+		nd->tech =3D ACCESS_TECHNOLOGY_EUTRAN;
+
+	/* for other technologies, notification ^MODE is used */
+}
+
 static void huawei_nwtime_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -1896,6 +1917,10 @@ static void at_creg_set_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 		g_at_chat_register(nd->chat, "^MODE:", huawei_mode_notify,
 						FALSE, netreg, NULL);
 =

+		/* Register for 4G system mode reports */
+		g_at_chat_register(nd->chat, "^HCSQ:", huawei_hcsq_notify,
+						FALSE, netreg, NULL);
+
 		/* Register for network time reports */
 		g_at_chat_register(nd->chat, "^NWTIME:", huawei_nwtime_notify,
 						FALSE, netreg, NULL);
-- =

2.7.4


--===============1436121685253936276==--

