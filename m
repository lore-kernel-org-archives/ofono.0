Content-Type: multipart/mixed; boundary="===============6011987138742359464=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v4 1/6] qmi: add missing header inclusion
Date: Tue, 18 Apr 2017 09:50:47 +0200
Message-ID: <20170418075052.23980-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6011987138742359464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/nas.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/qmimodem/nas.h b/drivers/qmimodem/nas.h
index b39b425..b4bc012 100644
--- a/drivers/qmimodem/nas.h
+++ b/drivers/qmimodem/nas.h
@@ -19,6 +19,8 @@
  *
  */
 =

+#include <stdint.h>
+
 #define QMI_NAS_RESET			0	/* Reset NAS service state variables */
 #define QMI_NAS_ABORT			1	/* Abort previously issued NAS command */
 #define QMI_NAS_EVENT			2	/* Connection state report indication */
-- =

2.9.3


--===============6011987138742359464==--

