Content-Type: multipart/mixed; boundary="===============1675918573905937258=="
MIME-Version: 1.0
From: Florian Steinel <Florian.Steinel@gmail.com>
Subject: [PATCH 1/1] (RFC) Huawei: Modify ^SYSINFO logic
Date: Mon, 19 Jul 2010 00:09:03 +0200
Message-ID: <20100718220903.GA10397@h02.hostsharing.net>
In-Reply-To: <20100718201936.GA29262@h02.hostsharing.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1675918573905937258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |  114 +++++++++++++++++++++++++++++++++++++++++++++++++-=
---
 1 files changed, 105 insertions(+), 9 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index cfc693d..c14b076 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -57,12 +57,22 @@
 =

 static const char *none_prefix[] =3D { NULL };
 static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
+static const char *cpin_prefix[] =3D { "CPIN:", NULL };
+
+enum my_sim_state {
+	SIM_STATE_INVALID_OR_PIN_BLOCKED =3D 0,
+	SIM_STATE_NORMAL_SIM_CARD =3D 1,
+	SIM_STATE_SIM_NOT_VALID_IN_CS_MODE =3D 2,
+	SIM_STATE_SIM_NOT_VALID_IN_PS_MODE =3D 3,
+	SIM_STATE_SIM_NOT_VALID_IN_CS_OR_PS_MODE =3D 4,
+	SIM_STATE_SIM_NOT_PRESENT =3D 255
+};
 =

 struct huawei_data {
 	GAtChat *modem;
 	GAtChat *pcui;
 	struct ofono_sim *sim;
-	gint sim_state;
+	enum my_sim_state sim_state;
 	struct ofono_gprs *gprs;
 	struct ofono_gprs_context *gc;
 };
@@ -101,19 +111,105 @@ static void huawei_debug(const char *str, void *user=
_data)
 	ofono_info("%s%s", prefix, str);
 }
 =

-static void notify_sim_state(struct ofono_modem *modem, gint sim_state)
+static void notify_sim_state(struct ofono_modem *modem, enum my_sim_state =
sim_state)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 =

-	if (data->sim_state =3D=3D 0 && sim_state =3D=3D 1) {
-		ofono_sim_inserted_notify(data->sim, TRUE);
-		data->sim_state =3D sim_state;
-	} else if (data->sim_state =3D=3D 1 && sim_state =3D=3D 0) {
-		ofono_sim_inserted_notify(data->sim, FALSE);
-		data->sim_state =3D sim_state;
+	switch (sim_state) {
+	case SIM_STATE_INVALID_OR_PIN_BLOCKED:
+		if (data->sim_state !=3D sim_state) {
+			/* TODO copy code from mbm.c function init_simpin_check and ff */
+			ofono_sim_inserted_notify(data->sim, TRUE);
+		}
+
+		break;
+
+	case SIM_STATE_NORMAL_SIM_CARD:
+		if (data->sim_state !=3D sim_state) {
+			ofono_sim_inserted_notify(data->sim, TRUE);
+		}
+
+		break;
+
+	case SIM_STATE_SIM_NOT_VALID_IN_CS_MODE:
+		if (data->sim_state !=3D sim_state) {
+			ofono_sim_inserted_notify(data->sim, FALSE);
+		}
+
+		break;
+
+	case SIM_STATE_SIM_NOT_VALID_IN_PS_MODE:
+		if (data->sim_state !=3D sim_state) {
+			ofono_sim_inserted_notify(data->sim, FALSE);
+		}
+
+		break;
+
+	case SIM_STATE_SIM_NOT_VALID_IN_CS_OR_PS_MODE:
+		if (data->sim_state !=3D sim_state) {
+			ofono_sim_inserted_notify(data->sim, FALSE);
+		}
+
+		break;
+
+	case SIM_STATE_SIM_NOT_PRESENT:
+		if (data->sim_state !=3D sim_state) {
+			ofono_sim_inserted_notify(data->sim, FALSE);
+		}
+
+		break;
+
+	default:
+		break;
 	}
+	data->sim_state =3D sim_state;
 }
 =

+/*
+ *
+ * SYSINFO =3D a,b,c,d,e,f
+ *
+ * a :
+ *   0 - no network access =

+ *   1 - limited access to the network =

+ *   2 - normal access to the network =

+ *   3 - limited access to networks in your area =

+ *   4 - Power saving mode =

+ * b:
+ *   0 - no access to the call date =

+ *   1 - only the circuit switching =

+ *   2 - only the packet switching =

+ *   3 - PS + SC =

+ *   4 - had not registered =

+ * c:
+ *   0 - registered in your home network =

+ *   1 - registered in roaming =

+ * d:
+ *   0 - no network access =

+ *   1 - APMs =

+ *   2 - CDMA =

+ *   3 - GSM / GPRS =

+ *   4 - HDR =

+ *   5 - WCDMA =

+ *   6 - GPS =

+ * e:
+ *   0 - invalid SIM card or PIN code blocked =

+ *   1 - normal SIM card =

+ *   2 - SIM card not valid in CS mode =

+ *   3 - SIM card not valid in PS mode =

+ *   4 - SIM card not valid in PS or CS mode =

+ * f:
+ *   0 - no network access =

+ *   1 - GSM mode =

+ *   2 - GPRS =

+ *   3 - Mode EDGE =

+ *   4 - WCDMA mode =

+ *   5 - HSDPA mode =

+ *   6 - HSUPA mode =

+ *   7 - mode HSPA =

+ *   8 - HSPA + mode
+ *
+ */
 static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -277,7 +373,7 @@ static int huawei_enable(struct ofono_modem *modem)
 		return -EIO;
 	}
 =

-	data->sim_state =3D 0;
+	data->sim_state =3D SIM_STATE_SIM_NOT_PRESENT;
 =

 	g_at_chat_send(data->pcui, "ATE0", none_prefix, NULL, NULL, NULL);
 =

-- =

1.7.1


--===============1675918573905937258==--

