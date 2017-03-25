Content-Type: multipart/mixed; boundary="===============5776562644397539600=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi 1/5] qmimodem: fix typo
Date: Sat, 25 Mar 2017 17:57:51 +0100
Message-ID: <20170325165755.28114-2-jonas@southpole.se>
In-Reply-To: <20170325165755.28114-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5776562644397539600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 8a9a88d..e50da19 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -330,7 +330,7 @@ static const char *__service_type_to_string(uint8_t typ=
e)
 	case QMI_SERVICE_TS:
 		return "TS";
 	case QMI_SERVICE_TMD:
-		return "TMS";
+		return "TMD";
 	case QMI_SERVICE_PDC:
 		return "PDC";
 	case QMI_SERVICE_CAT_OLD:
-- =

2.9.3


--===============5776562644397539600==--

