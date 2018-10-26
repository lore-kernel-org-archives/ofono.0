Content-Type: multipart/mixed; boundary="===============6559636256082624734=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 4/6] atmodem: add missing headers to atutil.h
Date: Fri, 26 Oct 2018 11:54:17 +0200
Message-ID: <20181026095419.26260-5-jonas@norrbonn.se>
In-Reply-To: <20181026095419.26260-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6559636256082624734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/atmodem/atutil.h b/drivers/atmodem/atutil.h
index f1389a94..d74c33d2 100644
--- a/drivers/atmodem/atutil.h
+++ b/drivers/atmodem/atutil.h
@@ -20,6 +20,9 @@
  *
  */
 =

+#include "gatchat.h"
+#include "gatresult.h"
+
 enum at_util_sms_store {
 	AT_UTIL_SMS_STORE_SM =3D	0,
 	AT_UTIL_SMS_STORE_ME =3D	1,
-- =

2.17.1


--===============6559636256082624734==--

