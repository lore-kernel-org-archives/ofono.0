Content-Type: multipart/mixed; boundary="===============9032219354500319101=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/3] huawei: Add Huawei EM770 modem support
Date: Tue, 29 Jun 2010 15:07:09 +0800
Message-ID: <1277795230-18323-3-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1277795230-18323-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9032219354500319101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei EM770W is a 3G WCDMA modem that supports HSPA/UMTS/EDGE/GPRS/GSM
data service and WCDMA/GSM short message services. It also has voice
call capability that supports both 2G and 3G network.
---
 plugins/huawei.c    |   31 ++++++++++++++++++++++++++++++-
 plugins/ofono.rules |    3 +++
 plugins/udev.c      |    3 +++
 3 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index e2dfd1e..0dc6ae4 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -43,13 +43,24 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/voicecall.h>
+#include <ofono/call-forwarding.h>
+#include <ofono/call-settings.h>
+#include <ofono/call-meter.h>
+#include <ofono/call-barring.h>
+#include <ofono/ssn.h>
+#include <ofono/phonebook.h>
+#include <ofono/message-waiting.h>
 #include <ofono/log.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
 =

+#define HUAWEI_MODEL_EM770W "1404"
+
 static const char *none_prefix[] =3D { NULL };
 static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
+static const char *model =3D "";
 =

 struct huawei_data {
 	GAtChat *modem;
@@ -205,8 +216,9 @@ static int huawei_enable(struct ofono_modem *modem)
 =

 	modem_device =3D ofono_modem_get_string(modem, "Modem");
 	pcui_device =3D ofono_modem_get_string(modem, "Pcui");
+	model =3D ofono_modem_get_string(modem, "Model");
 =

-	if (modem_device =3D=3D NULL || pcui_device =3D=3D NULL)
+	if (modem_device =3D=3D NULL || pcui_device =3D=3D NULL || model =3D=3D N=
ULL)
 		return -EINVAL;
 =

 	data->modem =3D create_port(modem_device);
@@ -288,6 +300,9 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
 	data->sim =3D ofono_sim_create(modem, 0, "atmodem", data->pcui);
+
+	if (g_str_equal(model, HUAWEI_MODEL_EM770W))
+		ofono_voicecall_create(modem, 0, "atmodem", data->pcui);
 }
 =

 static void huawei_post_sim(struct ofono_modem *modem)
@@ -296,6 +311,7 @@ static void huawei_post_sim(struct ofono_modem *modem)
 	struct ofono_gprs_context *gc;
 	struct ofono_netreg *netreg;
 	struct ofono_gprs *gprs;
+	struct ofono_message_waiting *mw;
 =

 	DBG("%p", modem);
 =

@@ -312,6 +328,19 @@ static void huawei_post_sim(struct ofono_modem *modem)
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
+
+	if (g_str_equal(model, HUAWEI_MODEL_EM770W)) {
+		ofono_call_forwarding_create(modem, 0, "atmodem", data->pcui);
+		ofono_call_settings_create(modem, 0, "atmodem", data->pcui);
+		ofono_call_meter_create(modem, 0, "atmodem", data->pcui);
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
index 06c5c8f..3541833 100644
--- a/plugins/ofono.rules
+++ b/plugins/ofono.rules
@@ -24,6 +24,9 @@ ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1401"=
, ENV{OFONO_IFACE_NUM}=3D=3D"02", E
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1402", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
+ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1404", ENV{OFONO_IFACE=
_NUM}=3D=3D"02", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
+
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1405", ENV{OFONO_IFACE=
_NUM}=3D=3D"03", ENV{OFONO_HUAWEI_TYPE}=3D"Modem"
 ATTRS{idVendor}=3D=3D"12d1", ATTRS{idProduct}=3D=3D"1405", ENV{OFONO_IFACE=
_NUM}=3D=3D"00", ENV{OFONO_HUAWEI_TYPE}=3D"Pcui"
 =

diff --git a/plugins/udev.c b/plugins/udev.c
index 09ee93e..7d34b0b 100644
--- a/plugins/udev.c
+++ b/plugins/udev.c
@@ -227,6 +227,9 @@ static void add_huawei(struct ofono_modem *modem,
 		const char *name =3D udev_list_entry_get_name(entry);
 		type =3D udev_list_entry_get_value(entry);
 =

+		if (g_str_equal(name, "ID_MODEL_ID") =3D=3D TRUE)
+			ofono_modem_set_string(modem, "Model", type);
+
 		if (g_str_equal(name, "OFONO_HUAWEI_TYPE") !=3D TRUE) {
 			entry =3D udev_list_entry_get_next(entry);
 			continue;
-- =

1.6.3.3


--===============9032219354500319101==--

