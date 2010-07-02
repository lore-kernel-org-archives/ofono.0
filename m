Content-Type: multipart/mixed; boundary="===============5249855016426158470=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] huawei: Add Huawei EM770 modem support
Date: Fri, 02 Jul 2010 11:04:34 +0800
Message-ID: <1278039874-9163-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278039874-9163-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5249855016426158470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei EM770W is a 3G WCDMA modem that supports HSPA/UMTS/EDGE/GPRS/GSM
data service and WCDMA/GSM short message services. It also has voice
call capability that supports both 2G and 3G network.
---
 plugins/huawei.c    |   23 +++++++++++++++++++++++
 plugins/ofono.rules |    4 ++++
 plugins/udev.c      |    8 ++++++++
 3 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 7c8703e..cfc693d 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -43,6 +43,13 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/voicecall.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-settings.h>
+#include <ofono/call-barring.h>
+#include <ofono/ssn.h>
+#include <ofono/phonebook.h>
+#include <ofono/message-waiting.h>
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/atutil.h>
@@ -326,12 +333,16 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
 	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->pcui);
+
+	if (ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE)
+		ofono_voicecall_create(modem, 0, "atmodem", data->pcui);
 }
 =

 static void huawei_post_sim(struct ofono_modem *modem)
 {
 	struct huawei_data *data =3D ofono_modem_get_data(modem);
 	struct ofono_netreg *netreg;
+	struct ofono_message_waiting *mw;
 =

 	DBG("%p", modem);
 =

@@ -348,6 +359,18 @@ static void huawei_post_sim(struct ofono_modem *modem)
 =

 	if (data->gprs && data->gc)
 		ofono_gprs_add_context(data->gprs, data->gc);
+
+	if (ofono_modem_get_boolean(modem, "HasVoice") =3D=3D TRUE) {
+		ofono_call_forwarding_create(modem, 0, "atmodem", data->pcui);
+		ofono_call_settings_create(modem, 0, "atmodem", data->pcui);
+		ofono_call_barring_create(modem, 0, "atmodem", data->pcui);
+		ofono_ssn_create(modem, 0, "atmodem", data->pcui);
+		ofono_phonebook_create(modem, 0, "atmodem", data->pcui);
+
+		mw =3D ofono_message_waiting_create(modem);
+		if (mw)
+			ofono_message_waiting_register(mw);
+	}
 }
 =

 static struct ofono_modem_driver huawei_driver =3D {
diff --git a/plugins/ofono.rules b/plugins/ofono.rules
index 06c5c8f..826b0da 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -24,6 +24,10 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1401=
", ENV{OFONO_IFACE_NUM}=3D=3D"02", E
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_HUAWE=
I_VOICE}=3D"1"
+
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1405", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1405", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

diff --git a/plugins/udev.c b/plugins/udev.c
index 09ee93e..75f8b6c 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -227,6 +227,14 @@ static void add_huawei(struct ofono_modem *modem,
 		const char *name =3D udev_list_entry_get_name(entry);
 		type =3D udev_list_entry_get_value(entry);
 =

+		if (g_str_equal(name, "OFONO_HUAWEI_VOICE") =3D=3D TRUE) {
+			gboolean value =3D g_str_equal(type, "1");
+
+			ofono_modem_set_boolean(modem, "HasVoice", value);
+			entry =3D udev_list_entry_get_next(entry);
+			continue;
+		}
+
 		if (g_str_equal(name, "OFONO_HUAWEI_TYPE") !=3D TRUE) {
 			entry =3D udev_list_entry_get_next(entry);
 			continue;
-- =

1.6.3.3


--===============5249855016426158470==--

