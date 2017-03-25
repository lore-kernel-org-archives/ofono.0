Content-Type: multipart/mixed; boundary="===============6390533923306039192=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi 2/5] qmimodem: add WDA service string
Date: Sat, 25 Mar 2017 17:57:52 +0100
Message-ID: <20170325165755.28114-3-jonas@southpole.se>
In-Reply-To: <20170325165755.28114-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6390533923306039192==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/qmimodem/qmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index e50da19..39fbb19 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -331,6 +331,8 @@ static const char *__service_type_to_string(uint8_t typ=
e)
 		return "TS";
 	case QMI_SERVICE_TMD:
 		return "TMD";
+	case QMI_SERVICE_WDA:
+		return "WDA";
 	case QMI_SERVICE_PDC:
 		return "PDC";
 	case QMI_SERVICE_CAT_OLD:
-- =

2.9.3


--===============6390533923306039192==--

