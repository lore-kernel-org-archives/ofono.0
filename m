Content-Type: multipart/mixed; boundary="===============8931011634998038028=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 05/10] hfpmodem: Implement hfp_slc_info_free
Date: Fri, 18 Jan 2013 20:21:51 -0300
Message-ID: <1358551316-27305-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358551316-27305-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8931011634998038028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

hfp_slc_info_free() was already being declared, but it was not defined
until now.
---
 drivers/hfpmodem/slc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 06153fc..f088a46 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -81,6 +81,14 @@ done:
 	memset(info->cind_pos, 0, sizeof(info->cind_pos));
 }
 =

+void hfp_slc_info_free(struct hfp_slc_info *info)
+{
+	g_free(info->codecs);
+
+	g_at_chat_unref(info->chat);
+	info->chat =3D NULL;
+}
+
 static void slc_establish_data_unref(gpointer userdata)
 {
 	struct slc_establish_data *sed =3D userdata;
-- =

1.7.11.7


--===============8931011634998038028==--

