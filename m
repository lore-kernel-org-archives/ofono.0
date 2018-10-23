Content-Type: multipart/mixed; boundary="===============6971252324252315746=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] atmodem/sms: added Gemalto vendor for CNMI command
Date: Tue, 23 Oct 2018 10:21:47 +0200
Message-ID: <20181023082147.31703-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6971252324252315746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sms.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 7638885e..380cd763 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -858,8 +858,18 @@ static gboolean build_cnmi_string(char *buf, int *cnmi=
_opts,
 					data->cnma_enabled ? "21" : "1", FALSE))
 		return FALSE;
 =

+	switch (data->vendor) {
+	case OFONO_VENDOR_GEMALTO:
+		mode =3D "0";
+		break;
+	default:
+		/* Sounds like 2 is the sanest mode */
+		mode =3D "20";
+		break;
+	}
+
 	/* Always deliver CB via +CBM, otherwise don't deliver at all */
-	if (!append_cnmi_element(buf, &len, cnmi_opts[2], "20", FALSE))
+	if (!append_cnmi_element(buf, &len, cnmi_opts[2], mode, FALSE))
 		return FALSE;
 =

 	/*
-- =

2.17.1


--===============6971252324252315746==--

