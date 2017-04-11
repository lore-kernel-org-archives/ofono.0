Content-Type: multipart/mixed; boundary="===============5958152900056128282=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 1/8] qmi: NAS definitions adjustment
Date: Tue, 11 Apr 2017 10:18:11 +0200
Message-ID: <20170411081818.19544-2-jonas@southpole.se>
In-Reply-To: <20170411081818.19544-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5958152900056128282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Calling the ps_state/cs_state alternatives *ATTACH_STATUS* was confusing
because there is also a status field in the *serving_system structure.
This patch does a minor rename and adds the appropriate definitions for
the status field.
---
 drivers/qmimodem/gprs.c |  2 +-
 drivers/qmimodem/nas.h  | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index 983223e..05ad4bd 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -47,7 +47,7 @@ static bool extract_ss_info(struct qmi_result *result, in=
t *status)
 	if (!ss)
 		return false;
 =

-	if (ss->ps_state =3D=3D QMI_NAS_ATTACH_STATUS_ATTACHED)
+	if (ss->ps_state =3D=3D QMI_NAS_ATTACH_STATE_ATTACHED)
 		*status =3D 0x01;
 	else
 		*status =3D 0x00;
diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
index dee9d70..9bb9a9a 100644
--- a/drivers/qmimodem/nas.h
+++ b/drivers/qmimodem/nas.h
@@ -140,9 +140,17 @@ struct qmi_nas_current_plmn {
 #define QMI_NAS_RESULT_LOCATION_AREA_CODE	0x1d	/* uint16 */
 #define QMI_NAS_RESULT_CELL_ID			0x1e	/* uint32 */
 =

-#define QMI_NAS_ATTACH_STATUS_INVALID		0x00
-#define QMI_NAS_ATTACH_STATUS_ATTACHED		0x01
-#define QMI_NAS_ATTACH_STATUS_DETACHED		0x02
+/* qmi_nas_serving_system.status */
+#define QMI_NAS_REGISTRATION_STATE_NOT_REGISTERED	0x00
+#define QMI_NAS_REGISTRATION_STATE_REGISTEREID		0x01
+#define QMI_NAS_REGISTRATION_STATE_SEARCHING		0x02
+#define QMI_NAS_REGISTRATION_STATE_DENIED		0x03
+#define QMI_NAS_REGISTRATION_STATE_UNKNOWN		0x04
+
+/* cs_state/ps_state */
+#define QMI_NAS_ATTACH_STATE_INVALID		0x00
+#define QMI_NAS_ATTACH_STATE_ATTACHED		0x01
+#define QMI_NAS_ATTACH_STATE_DETACHED		0x02
 =

 /* Get info about home network */
 #define QMI_NAS_RESULT_HOME_NETWORK		0x01
-- =

2.9.3


--===============5958152900056128282==--

