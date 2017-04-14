Content-Type: multipart/mixed; boundary="===============6435008436830751743=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH QMI LTE v2 02/13] qmi: fix typo
Date: Fri, 14 Apr 2017 23:36:35 +0200
Message-ID: <20170414213646.32066-3-jonas@southpole.se>
In-Reply-To: <20170414213646.32066-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6435008436830751743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/nas.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
index 9bb9a9a..b39b425 100644
--- a/drivers/qmimodem/nas.h
+++ b/drivers/qmimodem/nas.h
@@ -142,7 +142,7 @@ struct qmi_nas_current_plmn {
 =

 /* qmi_nas_serving_system.status */
 #define QMI_NAS_REGISTRATION_STATE_NOT_REGISTERED	0x00
-#define QMI_NAS_REGISTRATION_STATE_REGISTEREID		0x01
+#define QMI_NAS_REGISTRATION_STATE_REGISTERED		0x01
 #define QMI_NAS_REGISTRATION_STATE_SEARCHING		0x02
 #define QMI_NAS_REGISTRATION_STATE_DENIED		0x03
 #define QMI_NAS_REGISTRATION_STATE_UNKNOWN		0x04
-- =

2.9.3


--===============6435008436830751743==--

