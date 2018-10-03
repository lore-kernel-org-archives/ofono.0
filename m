Content-Type: multipart/mixed; boundary="===============1554439543907134824=="
MIME-Version: 1.0
From: Anirudh Gargi <anirudh.gargi@intel.com>
Subject: [PATCH] xmm7xxx: enable sms and phonebook support
Date: Wed, 03 Oct 2018 12:07:28 +0530
Message-ID: <1538548648-22855-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1554439543907134824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enable SMS and Phonebook atom for the xmm7xxx series modem.
SMS send and CREG eutran states fixed in atmodem driver to support
sms and phonebook feature for xmm7xxx based modems.
---
 plugins/xmm7xxx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index 9db87ad..a6dd097 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -50,6 +50,8 @@
 #include <ofono/lte.h>
 #include <ofono/ims.h>
 #include <ofono/sim-auth.h>
+#include <ofono/sms.h>
+#include <ofono/phonebook.h>
 =

 #include <drivers/atmodem/atutil.h>
 #include <drivers/atmodem/vendor.h>
@@ -128,13 +130,19 @@ static void switch_sim_state_status(struct ofono_mode=
m *modem, int status)
 		break;
 	case 2:	/* SIM inserted, PIN verification not needed - READY */
 	case 3:	/* SIM inserted, PIN verified - READY */
-	case 7:
+	case 7: /* SIM inserted, SMS and phonebook - READY */
 		if (data->have_sim =3D=3D FALSE) {
 			ofono_sim_inserted_notify(data->sim, TRUE);
 			data->have_sim =3D TRUE;
 		}
 =

 		ofono_sim_initialized_notify(data->sim);
+		if (data->sms_phonebook_added =3D=3D FALSE) {
+			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
+			ofono_sms_create(modem, 0, "atmodem", data->chat);
+			data->sms_phonebook_added =3D TRUE;
+		}
+
 		break;
 	default:
 		ofono_warn("Unknown SIM state %d received", status);
-- =

2.7.4


--===============1554439543907134824==--

