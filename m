Content-Type: multipart/mixed; boundary="===============5322000849280183095=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH v2 5/6] atmodem: add signal strength support for huawei
Date: Fri, 30 Apr 2010 15:55:24 +0300
Message-ID: <20100430125524.30019.86894.stgit@potku.valot.fi>
In-Reply-To: <20100430124405.30019.86945.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5322000849280183095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei doesn't support CIND indications, instead it uses some non-standard
RSSI messages:

ofonod[6401]: < \r\n^RSSI:23\r\n

Add support for this to atmodem.
---

 drivers/atmodem/network-registration.c |   30 ++++++++++++++++++++++++++++=
++
 drivers/atmodem/network-registration.h |    3 +++
 plugins/huawei.c                       |    1 +
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 777cbc3..95da94d 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -50,6 +50,7 @@ static const char *cind_prefix[] =3D { "+CIND:", NULL };
 =

 struct netreg_data {
 	GAtChat *chat;
+	GAtChat *event;
 	char mcc[OFONO_MAX_MCC_LENGTH + 1];
 	char mnc[OFONO_MAX_MNC_LENGTH + 1];
 	int signal_index; /* If strength is reported via CIND */
@@ -511,6 +512,23 @@ static void calypso_csq_notify(GAtResult *result, gpoi=
nter user_data)
 	report_signal_strength(netreg, strength);
 }
 =

+static void huawei_rssi_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	int strength;
+	GAtResultIter iter;
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "^RSSI:"))
+		return;
+
+	if (!g_at_result_iter_next_number(&iter, &strength))
+		return;
+
+	report_signal_strength(netreg, strength);
+}
+
 static void option_osigq_notify(GAtResult *result, gpointer user_data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -917,6 +935,17 @@ static void at_creg_set_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 				cind_support_cb, netreg, NULL);
 =

 		break;
+	case OFONO_VENDOR_HUAWEI:
+		if (!nd->event)
+			break;
+
+		/* huawei reports with non-standard "^RSSI:18" strings */
+		g_at_chat_register(nd->event, "^RSSI:",
+				   huawei_rssi_notify, FALSE, netreg, NULL);
+
+		ofono_netreg_register(netreg);
+
+		break;
 	default:
 		g_at_chat_send(nd->chat, "AT+CIND=3D?", cind_prefix,
 				cind_support_cb, netreg, NULL);
@@ -979,6 +1008,7 @@ static int at_netreg_probe(struct ofono_netreg *netreg=
, unsigned int vendor,
 	nd =3D g_new0(struct netreg_data, 1);
 =

 	nd->chat =3D nr->chat;
+	nd->event =3D nr->event;
 	nd->vendor =3D vendor;
 	nd->tech =3D -1;
 	ofono_netreg_set_data(netreg, nd);
diff --git a/drivers/atmodem/network-registration.h b/drivers/atmodem/netwo=
rk-registration.h
index 506ed7d..7c832ea 100644
--- a/drivers/atmodem/network-registration.h
+++ b/drivers/atmodem/network-registration.h
@@ -23,4 +23,7 @@ struct atmodem_network_registration
 {
 	/* primary chat channel */
 	GAtChat *chat;
+
+	/* secondary chat channel for events */
+	GAtChat *event;
 };
diff --git a/plugins/huawei.c b/plugins/huawei.c
index e895d16..30e98f9 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -222,6 +222,7 @@ static void huawei_post_sim(struct ofono_modem *modem)
 =

 	memset(&atmodem_netreg, 0, sizeof(atmodem_netreg));
 	atmodem_netreg.chat =3D data->chat;
+	atmodem_netreg.event =3D data->event;
 =

 	ofono_netreg_create(modem, OFONO_VENDOR_HUAWEI, "atmodem",
 			    &atmodem_netreg);


--===============5322000849280183095==--

