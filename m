Content-Type: multipart/mixed; boundary="===============2245026253344327833=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] sms: SMS-PP download must be enabled in SIM service
 tables.
Date: Wed, 10 Nov 2010 04:27:51 +0100
Message-ID: <1289359672-19206-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1289359672-19206-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2245026253344327833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sms.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index eba4564..fe45ef3 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -37,6 +37,7 @@
 #include "util.h"
 #include "smsutil.h"
 #include "storage.h"
+#include "simutil.h"
 =

 #define uninitialized_var(x) x =3D x
 =

@@ -1417,6 +1418,7 @@ void ofono_sms_deliver_notify(struct ofono_sms *sms, =
unsigned char *pdu,
 {
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(sms->atom);
 	struct ofono_atom *stk_atom;
+	struct ofono_atom *sim_atom;
 	struct sms s;
 	enum sms_class cls;
 =

@@ -1485,6 +1487,17 @@ void ofono_sms_deliver_notify(struct ofono_sms *sms,=
 unsigned char *pdu,
 		if (cls !=3D SMS_CLASS_2)
 			break;
 =

+		sim_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_SIM);
+
+		if (!sim_atom)
+			return;
+
+		if (!__ofono_sim_service_available(
+					__ofono_atom_get_data(sim_atom),
+					SIM_UST_SERVICE_DATA_DOWNLOAD_SMS_PP,
+					SIM_SST_SERVICE_DATA_DOWNLOAD_SMS_PP))
+			return;
+
 		stk_atom =3D __ofono_modem_find_atom(modem, OFONO_ATOM_TYPE_STK);
 =

 		if (!stk_atom)
-- =

1.7.1.86.g0e460.dirty


--===============2245026253344327833==--

