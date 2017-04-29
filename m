Content-Type: multipart/mixed; boundary="===============6754089502333990287=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v5 3/4] qmi: use named status values
Date: Sat, 29 Apr 2017 14:46:42 +0200
Message-ID: <20170429124643.21080-4-jonas@southpole.se>
In-Reply-To: <20170429124643.21080-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6754089502333990287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/gprs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index fb5e6ec..e3bfd1f 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -30,6 +30,7 @@
 #include "qmi.h"
 #include "nas.h"
 =

+#include "src/common.h"
 #include "qmimodem.h"
 =

 struct gprs_data {
@@ -48,9 +49,9 @@ static bool extract_ss_info(struct qmi_result *result, in=
t *status)
 		return false;
 =

 	if (ss->ps_state =3D=3D QMI_NAS_ATTACH_STATE_ATTACHED)
-		*status =3D 0x01;
+		*status =3D NETWORK_REGISTRATION_STATUS_REGISTERED;
 	else
-		*status =3D 0x00;
+		*status =3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
 =

 	return true;
 }
-- =

2.9.3


--===============6754089502333990287==--

