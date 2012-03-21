Content-Type: multipart/mixed; boundary="===============1979313349497915227=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] sim: Use quoted string with AT+CRSM data parameter
Date: Wed, 21 Mar 2012 13:57:13 +0100
Message-ID: <1332334633-11737-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1979313349497915227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix issue with some modems preventing to update elementary files
(speedup, ZTE, huawei, MBM)
---
 drivers/atmodem/sim.c |   52 ++++++++++++++++++++++++++++++++++++++++++---=
---
 1 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 8ee9822..f307708 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -305,18 +305,38 @@ static void at_sim_update_binary(struct ofono_sim *si=
m, int fileid,
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char *buf =3D g_try_new(char, 36 + length * 2);
+	char *buf;
 	int len, ret;
+	int size =3D 36 + length * 2;
 =

+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
+			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
+			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
+		size +=3D 2; /*Add quotes*/
+
+	buf =3D g_try_new(char, size);
 	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+CRSM=3D214,%i,%i,%i,%i,", fileid,
 			start >> 8, start & 0xff, length);
 =

+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
+			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
+			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
+		sprintf(buf + len, "\"");
+
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
+			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
+			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
+		sprintf(buf + len, "\"");
+
 	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_update_cb, cbd, g_free);
 =

@@ -342,7 +362,10 @@ static void at_sim_update_record(struct ofono_sim *sim=
, int fileid,
 	int len, ret;
 	int size =3D 36 + length * 2;
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
+			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
+			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
 		size +=3D 2; /*Add quotes*/
 =

 	buf =3D g_try_new(char, size);
@@ -352,13 +375,19 @@ static void at_sim_update_record(struct ofono_sim *si=
m, int fileid,
 	len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid,
 			record, length);
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
+			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
+			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
 		len +=3D sprintf(buf + len, "\"");
 =

 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
+			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
+			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
 		sprintf(buf + len, "\"");
 =

 	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
@@ -385,7 +414,10 @@ static void at_sim_update_cyclic(struct ofono_sim *sim=
, int fileid,
 	int len, ret;
 	int size =3D 36 + length * 2;
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
+			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
+			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
 		size +=3D 2; /* Add quotes */
 =

 	buf =3D g_try_new(char, size);
@@ -394,13 +426,19 @@ static void at_sim_update_cyclic(struct ofono_sim *si=
m, int fileid,
 =

 	len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,", fileid, length);
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
+			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
+			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
 		len +=3D sprintf(buf + len, "\"");
 =

 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM ||
+			sd->vendor =3D=3D OFONO_VENDOR_ZTE ||
+			sd->vendor =3D=3D OFONO_VENDOR_HUAWEI ||
+			sd->vendor =3D=3D OFONO_VENDOR_SPEEDUP)
 		sprintf(buf + len, "\"");
 =

 	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
-- =

1.7.5.4


--===============1979313349497915227==--

