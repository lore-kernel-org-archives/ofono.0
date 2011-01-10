Content-Type: multipart/mixed; boundary="===============6379377874464910707=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 1/6] atmodem: check for VENDOR_HUAWEI on sim atom
Date: Mon, 10 Jan 2011 19:02:26 -0200
Message-ID: <1294693351-25475-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294693351-25475-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6379377874464910707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/sim.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
index 1653ede..33f756d 100644
--- a/drivers/atmodem/sim.c
+++ b/drivers/atmodem/sim.c
@@ -143,8 +143,10 @@ static void at_sim_read_info(struct ofono_sim *sim, in=
t fileid,
 =

 	snprintf(buf, sizeof(buf), "AT+CRSM=3D192,%i", fileid);
 =

-	if (sd->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM)
+	if (sd->vendor =3D=3D OFONO_VENDOR_QUALCOMM_MSM ||
+					sd->vendor =3D=3D OFONO_VENDOR_HUAWEI) {
 		strcat(buf, ",0,0,255"); /* Maximum possible length */
+	}
 =

 	if (g_at_chat_send(sd->chat, buf, crsm_prefix,
 				at_crsm_info_cb, cbd, g_free) > 0)
-- =

1.7.3.5


--===============6379377874464910707==--

