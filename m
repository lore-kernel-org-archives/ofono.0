Content-Type: multipart/mixed; boundary="===============0230895889011704127=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 3/3] gemalto: netmon measurements scaling
Date: Fri, 15 Jan 2021 19:25:47 +0300
Message-ID: <20210115162547.17156-4-geomatsi@gmail.com>
In-Reply-To: <20210115162547.17156-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0230895889011704127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Gemalto modem reports raw measurements in dBm. Reported values may
include negative numbers. Meanwhile oFono follows ETSI TS 27.007,
so negative numbers do not really exist at the API level.

Modify gemalto netmon driver to report measurements according to
27.007. For this purpose re-scale from what Gemalto firmware
reports into something that 27.007 recommends.
---
 drivers/gemaltomodem/netmon.c | 52 ++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/gemaltomodem/netmon.c b/drivers/gemaltomodem/netmon.c
index ddaebf1a..c3a0498d 100644
--- a/drivers/gemaltomodem/netmon.c
+++ b/drivers/gemaltomodem/netmon.c
@@ -128,6 +128,50 @@ static gboolean gemalto_delayed_register(gpointer user=
_data)
 	return FALSE;
 }
 =

+static int gemalto_ecno_scale(int value)
+{
+	if (value < -24)
+		return 0;
+
+	if (value > 0)
+		return 49;
+
+	return 49 * (value + 24) / 24;
+}
+
+static int gemalto_rscp_scale(int value)
+{
+	if (value < -120)
+		return 0;
+
+	if (value > -24)
+		return 96;
+
+	return (value + 120);
+}
+
+static int gemalto_rsrp_scale(int value)
+{
+	if (value < -140)
+		return 0;
+
+	if (value > -43)
+		return 97;
+
+	return (value + 140);
+}
+
+static int gemalto_rsrq_scale(int value)
+{
+	if (2 * value < -39)
+		return 0;
+
+	if (2 * value > -5)
+		return 34;
+
+	return (2 * value + 39);
+}
+
 static int gemalto_parse_smoni_gsm(GAtResultIter *iter,
 					struct req_cb_data *cbd)
 {
@@ -273,13 +317,13 @@ static int gemalto_parse_smoni_umts(GAtResultIter *it=
er,
 		case SMONI_UMTS_ECN0:
 			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
 				if (sscanf(str, "%f", &fnumber) =3D=3D 1)
-					cbd->t.umts.ecno =3D (int)fnumber;
+					cbd->t.umts.ecno =3D gemalto_ecno_scale((int)fnumber);
 			}
 			break;
 		case SMONI_UMTS_RSCP:
 			if (g_at_result_iter_next_unquoted_string(iter, &str)) {
 				if (sscanf(str, "%d", &number) =3D=3D 1)
-					cbd->t.umts.rscp =3D number;
+					cbd->t.umts.rscp =3D gemalto_rscp_scale(number);
 			}
 			break;
 		case SMONI_UMTS_MCC:
@@ -368,12 +412,12 @@ static int gemalto_parse_smoni_lte(GAtResultIter *ite=
r,
 =

 	if (g_at_result_iter_next_unquoted_string(iter, &str)) {
 		if (sscanf(str, "%d", &number) =3D=3D 1)
-			cbd->t.lte.rsrp =3D number;
+			cbd->t.lte.rsrp =3D gemalto_rsrp_scale(number);
 	}
 =

 	if (g_at_result_iter_next_unquoted_string(iter, &str)) {
 		if (sscanf(str, "%d", &number) =3D=3D 1)
-			cbd->t.lte.rsrq =3D number;
+			cbd->t.lte.rsrq =3D gemalto_rsrq_scale(number);
 	}
 =

 	DBG(" %-15s %s", "LTE.MCC", cbd->op.mcc);
--===============0230895889011704127==--

