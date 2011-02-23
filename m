Content-Type: multipart/mixed; boundary="===============6519023171813655851=="
MIME-Version: 1.0
From: Miia Leinonen <miia.leinonen@tieto.com>
Subject: [PATCH] atmodem: Add MBM/STE quirk for SIM record update
Date: Wed, 23 Feb 2011 10:09:23 +0200
Message-ID: <1298448563-5033-1-git-send-email-miia.leinonen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6519023171813655851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixed the <data> string to be set inside quotes for STE/MBM.

---

Hi,

This fix has been tested with STE modem only due the lack of MBM HW.

Would it be possible that someone checks this with MBM modem? The problem i=
s =

likely to appear also there - therefore OFONO_VENDOR_MBM used. Could fix th=
is =

also to cover all modems, but that might cause some backward compatibility =

issues.

BR,
Miia


 drivers/atmodem/sim.c |   59 ++++++++++++++++++++++++++++++++++++++-------=
---
 1 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d9c0d8d..7a0100a 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -332,17 +332,34 @@ static void at_sim_update_record(struct ofono_sim *si=
m, int fileid,
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char *buf =3D g_try_new(char, 36 + length * 2);
+	char *buf;
 	int len, ret;
 =

-	if (buf =3D=3D NULL)
-		goto error;
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM) {
+		buf =3D g_try_new(char, 36 + 2 + length * 2);
 =

-	len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid,
-			record, length);
+		if (buf =3D=3D NULL)
+			goto error;
 =

-	for (; length; length--)
-		len +=3D sprintf(buf + len, "%02hhX", *value++);
+		len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,\"", fileid,
+					record, length);
+
+		for (; length; length--)
+			len +=3D sprintf(buf + len, "%02hhX", *value++);
+
+		sprintf(buf + len, "\"");
+	} else {
+		buf =3D g_try_new(char, 36 + length * 2);
+
+		if (buf =3D=3D NULL)
+			goto error;
+
+		len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid,
+				record, length);
+
+		for (; length; length--)
+			len +=3D sprintf(buf + len, "%02hhX", *value++);
+	}
 =

 	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_update_cb, cbd, g_free);
@@ -364,16 +381,32 @@ static void at_sim_update_cyclic(struct ofono_sim *si=
m, int fileid,
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char *buf =3D g_try_new(char, 36 + length * 2);
+	char *buf;
 	int len, ret;
 =

-	if (buf =3D=3D NULL)
-		goto error;
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM) {
+		buf =3D g_try_new(char, 36 + 2 + length * 2);
 =

-	len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,", fileid, length);
+		if (buf =3D=3D NULL)
+			goto error;
 =

-	for (; length; length--)
-		len +=3D sprintf(buf + len, "%02hhX", *value++);
+		len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,\"", fileid, length);
+
+		for (; length; length--)
+			len +=3D sprintf(buf + len, "%02hhX", *value++);
+
+		sprintf(buf + len, "\"");
+	} else {
+		buf =3D g_try_new(char, 36 + length * 2);
+
+		if (buf =3D=3D NULL)
+			goto error;
+
+		len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,", fileid, length);
+
+		for (; length; length--)
+			len +=3D sprintf(buf + len, "%02hhX", *value++);
+	}
 =

 	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_update_cb, cbd, g_free);
-- =

1.7.1


--===============6519023171813655851==--

