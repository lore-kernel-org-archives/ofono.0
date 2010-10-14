Content-Type: multipart/mixed; boundary="===============5205813019755815562=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 5/8] isimodem: returns file-status of SIM EF-file
Date: Fri, 15 Oct 2010 00:02:52 +0300
Message-ID: <1287090175-3018-6-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1287090175-3018-5-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5205813019755815562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/sim.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index 44e539a..d978c85 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -54,6 +54,7 @@ struct file_info {
 	int structure;
 	int record_length;
 	unsigned char access[3];
+	unsigned char file_status;
 };
 =

 /* Returns file info */
@@ -66,7 +67,7 @@ static gboolean fake_file_info(gpointer user)
 	DBG("Returning static file_info for %04x", fi->fileid);
 	CALLBACK_WITH_SUCCESS(cb,
 				fi->length, fi->structure, fi->record_length,
-				fi->access, cbd->data);
+				fi->access, fi->file_status, cbd->data);
 	g_free(cbd);
 	return FALSE;
 }
@@ -76,8 +77,8 @@ static void isi_read_file_info(struct ofono_sim *sim, int=
 fileid,
 {
 	int i;
 	static struct file_info const info[] =3D {
-		{ SIM_EFSPN_FILEID, 17, 0, 0, { 0x0f, 0xff, 0xff } },
-		{ SIM_EF_ICCID_FILEID, 10, 0, 0, { 0x0f, 0xff, 0xff } },
+		{ SIM_EFSPN_FILEID, 17, 0, 0, { 0x0f, 0xff, 0xff }, 1 },
+		{ SIM_EF_ICCID_FILEID, 10, 0, 0, { 0x0f, 0xff, 0xff }, 1 },
 	};
 	int N =3D sizeof(info) / sizeof(info[0]);
 	struct isi_cb_data *cbd;
@@ -91,7 +92,7 @@ static void isi_read_file_info(struct ofono_sim *sim, int=
 fileid,
 	}
 =

 	DBG("Not implemented (fileid =3D %04x)", fileid);
-	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, data);
+	CALLBACK_WITH_FAILURE(cb, -1, -1, -1, NULL, 0, data);
 }
 =

 static gboolean spn_resp_cb(GIsiClient *client,
-- =

1.6.3.3



--===============5205813019755815562==--

