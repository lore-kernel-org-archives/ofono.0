Content-Type: multipart/mixed; boundary="===============5275877991771270767=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] huawei: Add support for radio settings
Date: Tue, 30 Nov 2010 16:41:36 -0200
Message-ID: <1291142496-26103-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1291142496-26103-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5275877991771270767==
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

1.7.3.2


--===============5275877991771270767==--

