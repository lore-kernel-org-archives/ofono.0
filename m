Content-Type: multipart/mixed; boundary="===============4797837016093922919=="
MIME-Version: 1.0
From: Miia Leinonen <miia.leinonen@tieto.com>
Subject: [PATCH v2] atmodem: Add MBM vendor quirk for SIM record update
Date: Wed, 02 Mar 2011 14:56:52 +0200
Message-ID: <1299070612-11563-1-git-send-email-miia.leinonen@tieto.com>
In-Reply-To: <4D6D6593.2020309@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4797837016093922919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---

Hi Denis,

Modified the fix according to your comment to remove duplicate code.

BR,
Miia

 drivers/atmodem/sim.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index d9c0d8d..c26e44d 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -332,18 +332,30 @@ static void at_sim_update_record(struct ofono_sim *si=
m, int fileid,
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char *buf =3D g_try_new(char, 36 + length * 2);
+	char *buf;
 	int len, ret;
 =

+	int size =3D 36 + length * 2;
+
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+		size +=3D 2; /*Add quotes*/
+
+	buf =3D g_try_new(char, size);
 	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+CRSM=3D220,%i,%i,4,%i,", fileid,
 			record, length);
 =

+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+		len +=3D sprintf(buf + len, "\"");
+
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+		sprintf(buf + len, "\"");
+
 	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_update_cb, cbd, g_free);
 =

@@ -364,17 +376,29 @@ static void at_sim_update_cyclic(struct ofono_sim *si=
m, int fileid,
 {
 	struct sim_data *sd =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, data);
-	char *buf =3D g_try_new(char, 36 + length * 2);
+	char *buf;
 	int len, ret;
 =

+	int size =3D 36 + length * 2;
+
+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+		size +=3D 2; /* Add quotes */
+
+	buf =3D g_try_new(char, size);
 	if (buf =3D=3D NULL)
 		goto error;
 =

 	len =3D sprintf(buf, "AT+CRSM=3D220,%i,0,3,%i,", fileid, length);
 =

+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+		len +=3D sprintf(buf + len, "\"");
+
 	for (; length; length--)
 		len +=3D sprintf(buf + len, "%02hhX", *value++);
 =

+	if (sd->vendor =3D=3D OFONO_VENDOR_MBM)
+		sprintf(buf + len, "\"");
+
 	ret =3D g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_update_cb, cbd, g_free);
 =

-- =

1.7.1


--===============4797837016093922919==--

