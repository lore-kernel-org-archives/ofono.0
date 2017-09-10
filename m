Content-Type: multipart/mixed; boundary="===============9042759327588540208=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: [PATCH v3] gobi: enable message waiting atom
Date: Sat, 09 Sep 2017 23:16:03 -0700
Message-ID: <20170912055650.CF06460F2C@rivendell.scintill.net>
In-Reply-To: <2dcbb720-fb26-d32d-f2c7-79c1a9dac91b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9042759327588540208==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

On 09/10/2017 10:59 AM, Denis Kenzior wrote:
> Does DMS provide support to twiddle the EFmwis/EFmwi/EFmbdn by some =

> other means?  From what I remember it doesn't, but may be I'm not =

> remembering correctly.
> =

> If not, then we shouldn't enable message-waiting in that case.

I'm not an expert, but from looking Gobi API, maybe the PBM service can
update MBDN (eQMIPBMPhonebookTypes_MailBoxDialingNumber) and WMS could
update MWI (WMSSetWaitingMessage). I don't see docs or examples of how
they work though, and I haven't tried. I also don't know if it makes
sense for oFono's target devices that don't have/use the UIM service.

Since the legacy SIM atom doesn't have that now, I've made the feature
check for the UIM service, as well as not "ForceSimLegacy" flag.

 plugins/gobi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index a498599..59416f2 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -45,6 +45,7 @@
 #include <ofono/radio-settings.h>
 #include <ofono/location-reporting.h>
 #include <ofono/log.h>
+#include <ofono/message-waiting.h>
 =

 #include <drivers/qmimodem/qmi.h>
 #include <drivers/qmimodem/dms.h>
@@ -483,6 +484,15 @@ static void gobi_post_sim(struct ofono_modem *modem)
 =

 	if (data->features & GOBI_WMS)
 		ofono_sms_create(modem, 0, "qmimodem", data->device);
+
+	if ((data->features & GOBI_WMS) && (data->features & GOBI_UIM) &&
+			!ofono_modem_get_boolean(modem, "ForceSimLegacy")) {
+		struct ofono_message_waiting *mw =3D
+					ofono_message_waiting_create(modem);
+
+		if (mw)
+			ofono_message_waiting_register(mw);
+	}
 }
 =

 static void gobi_post_online(struct ofono_modem *modem)
-- =

2.7.4


--===============9042759327588540208==--

