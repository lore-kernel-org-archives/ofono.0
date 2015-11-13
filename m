Content-Type: multipart/mixed; boundary="===============0745906426223921193=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 4/7] rilmodem: Export functions needed by mtkmodem
Date: Fri, 13 Nov 2015 13:25:07 +0100
Message-ID: <1447417510-9368-5-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1447417510-9368-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0745906426223921193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/radio-settings.c | 21 +++++++-----------
 drivers/rilmodem/radio-settings.h | 46 +++++++++++++++++++++++++++++++++++=
++++
 drivers/rilmodem/voicecall.c      | 18 ++++++++++-----
 drivers/rilmodem/voicecall.h      |  4 ++++
 4 files changed, 71 insertions(+), 18 deletions(-)
 create mode 100644 drivers/rilmodem/radio-settings.h

diff --git a/drivers/rilmodem/radio-settings.c b/drivers/rilmodem/radio-set=
tings.c
index 90b49c6..5b47089 100644
--- a/drivers/rilmodem/radio-settings.c
+++ b/drivers/rilmodem/radio-settings.c
@@ -40,6 +40,7 @@
 #include "gril.h"
 =

 #include "rilmodem.h"
+#include "radio-settings.h"
 =

 /* Preferred network types */
 #define PREF_NET_TYPE_GSM_WCDMA 0
@@ -64,12 +65,6 @@
 #define MTK_PREF_NET_TYPE_LTE_GSM_TYPE (MTK_PREF_NET_TYPE_BASE + 5)
 #define MTK_PREF_NET_TYPE_LTE_GSM_MMDC_TYPE (MTK_PREF_NET_TYPE_BASE + 6)
 =

-struct radio_data {
-	GRil *ril;
-	gboolean fast_dormancy;
-	gboolean pending_fd;
-};
-
 static void ril_set_rat_cb(struct ril_msg *message, gpointer user_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -86,7 +81,7 @@ static void ril_set_rat_cb(struct ril_msg *message, gpoin=
ter user_data)
 	}
 }
 =

-static void ril_set_rat_mode(struct ofono_radio_settings *rs,
+void ril_set_rat_mode(struct ofono_radio_settings *rs,
 			enum ofono_radio_access_mode mode,
 			ofono_radio_settings_rat_mode_set_cb_t cb,
 			void *data)
@@ -205,7 +200,7 @@ error:
 	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 }
 =

-static void ril_query_rat_mode(struct ofono_radio_settings *rs,
+void ril_query_rat_mode(struct ofono_radio_settings *rs,
 			ofono_radio_settings_rat_mode_query_cb_t cb,
 			void *data)
 {
@@ -220,7 +215,7 @@ static void ril_query_rat_mode(struct ofono_radio_setti=
ngs *rs,
 	CALLBACK_WITH_FAILURE(cb, -1, data);
 }
 =

-static void ril_query_fast_dormancy(struct ofono_radio_settings *rs,
+void ril_query_fast_dormancy(struct ofono_radio_settings *rs,
 			ofono_radio_settings_fast_dormancy_query_cb_t cb,
 			void *data)
 {
@@ -247,7 +242,7 @@ static void ril_display_state_cb(struct ril_msg *messag=
e, gpointer user_data)
 	}
 }
 =

-static void ril_set_fast_dormancy(struct ofono_radio_settings *rs,
+void ril_set_fast_dormancy(struct ofono_radio_settings *rs,
 				ofono_bool_t enable,
 				ofono_radio_settings_fast_dormancy_set_cb_t cb,
 				void *data)
@@ -272,7 +267,7 @@ static void ril_set_fast_dormancy(struct ofono_radio_se=
ttings *rs,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

-static void ril_query_available_rats(struct ofono_radio_settings *rs,
+void ril_query_available_rats(struct ofono_radio_settings *rs,
 			ofono_radio_settings_available_rats_query_cb_t cb,
 			void *data)
 {
@@ -288,7 +283,7 @@ static void ril_query_available_rats(struct ofono_radio=
_settings *rs,
 	CALLBACK_WITH_SUCCESS(cb, available_rats, data);
 }
 =

-static void ril_delayed_register(const struct ofono_error *error,
+void ril_delayed_register(const struct ofono_error *error,
 							void *user_data)
 {
 	struct ofono_radio_settings *rs =3D user_data;
@@ -314,7 +309,7 @@ static int ril_radio_settings_probe(struct ofono_radio_=
settings *rs,
 	return 0;
 }
 =

-static void ril_radio_settings_remove(struct ofono_radio_settings *rs)
+void ril_radio_settings_remove(struct ofono_radio_settings *rs)
 {
 	struct radio_data *rd =3D ofono_radio_settings_get_data(rs);
 	ofono_radio_settings_set_data(rs, NULL);
diff --git a/drivers/rilmodem/radio-settings.h b/drivers/rilmodem/radio-set=
tings.h
new file mode 100644
index 0000000..6c61551
--- /dev/null
+++ b/drivers/rilmodem/radio-settings.h
@@ -0,0 +1,46 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2014  Canonical Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+struct radio_data {
+	GRil *ril;
+	gboolean fast_dormancy;
+	gboolean pending_fd;
+};
+
+void ril_delayed_register(const struct ofono_error *error, void *user_data=
);
+void ril_radio_settings_remove(struct ofono_radio_settings *rs);
+void ril_query_rat_mode(struct ofono_radio_settings *rs,
+			ofono_radio_settings_rat_mode_query_cb_t cb,
+			void *data);
+void ril_set_rat_mode(struct ofono_radio_settings *rs,
+			enum ofono_radio_access_mode mode,
+			ofono_radio_settings_rat_mode_set_cb_t cb,
+			void *data);
+void ril_query_fast_dormancy(struct ofono_radio_settings *rs,
+			ofono_radio_settings_fast_dormancy_query_cb_t cb,
+			void *data);
+void ril_set_fast_dormancy(struct ofono_radio_settings *rs,
+				ofono_bool_t enable,
+				ofono_radio_settings_fast_dormancy_set_cb_t cb,
+				void *data);
+void ril_query_available_rats(struct ofono_radio_settings *rs,
+			ofono_radio_settings_available_rats_query_cb_t cb,
+			void *data);
diff --git a/drivers/rilmodem/voicecall.c b/drivers/rilmodem/voicecall.c
index 45e8ffb..c28274f 100644
--- a/drivers/rilmodem/voicecall.c
+++ b/drivers/rilmodem/voicecall.c
@@ -752,12 +752,11 @@ static gboolean ril_delayed_register(gpointer user_da=
ta)
 	return FALSE;
 }
 =

-int ril_voicecall_probe(struct ofono_voicecall *vc, unsigned int vendor,
-			void *data)
+void ril_voicecall_start(GRil *ril,
+				struct ofono_voicecall *vc,
+				unsigned int vendor,
+				struct ril_voicecall_data *vd)
 {
-	GRil *ril =3D data;
-	struct ril_voicecall_data *vd =3D g_new0(struct ril_voicecall_data, 1);
-
 	vd->ril =3D g_ril_clone(ril);
 	vd->vendor =3D vendor;
 	vd->cb =3D NULL;
@@ -768,6 +767,15 @@ int ril_voicecall_probe(struct ofono_voicecall *vc, un=
signed int vendor,
 	ofono_voicecall_set_data(vc, vd);
 =

 	g_idle_add(ril_delayed_register, vc);
+}
+
+int ril_voicecall_probe(struct ofono_voicecall *vc, unsigned int vendor,
+			void *data)
+{
+	GRil *ril =3D data;
+	struct ril_voicecall_data *vd =3D g_new0(struct ril_voicecall_data, 1);
+
+	ril_voicecall_start(ril, vc, vendor, vd);
 =

 	return 0;
 }
diff --git a/drivers/rilmodem/voicecall.h b/drivers/rilmodem/voicecall.h
index 31e120e..8888450 100644
--- a/drivers/rilmodem/voicecall.h
+++ b/drivers/rilmodem/voicecall.h
@@ -62,5 +62,9 @@ void ril_set_udub(struct ofono_voicecall *vc,
 void ril_release_all_active(struct ofono_voicecall *vc,
 				ofono_voicecall_cb_t cb, void *data);
 =

+void ril_voicecall_start(GRil *ril,
+				struct ofono_voicecall *vc,
+				unsigned int vendor,
+				struct ril_voicecall_data *vd);
 void ril_call_state_notify(struct ril_msg *message, gpointer user_data);
 gboolean ril_poll_clcc(gpointer user_data);
-- =

2.5.0


--===============0745906426223921193==--

