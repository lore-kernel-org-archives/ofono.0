Content-Type: multipart/mixed; boundary="===============8364591465238061949=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/6] huawei: Add support for radio settings
Date: Thu, 09 Dec 2010 14:43:37 -0200
Message-ID: <1291913020-3103-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1291913020-3103-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8364591465238061949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index 25dfaca..3c58c7f 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -43,6 +43,7 @@
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/audio-settings.h>
+#include <ofono/radio-settings.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-forwarding.h>
 #include <ofono/call-settings.h>
@@ -629,6 +630,9 @@ static void huawei_post_online(struct ofono_modem *mode=
m)
 	ofono_ussd_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 						"atmodem", data->pcui);
 =

+	ofono_radio_settings_create(modem, OFONO_VENDOR_HUAWEI, "huaweimodem",
+								data->pcui);
+
 	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
 			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
 		data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
-- =

1.7.3.3


--===============8364591465238061949==--

