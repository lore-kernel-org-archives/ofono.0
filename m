Content-Type: multipart/mixed; boundary="===============1021973118407372322=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 07/10] hfpmodem: Implement hfp_slc_info_free
Date: Tue, 22 Jan 2013 18:43:22 -0300
Message-ID: <1358891005-24688-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358891005-24688-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1021973118407372322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add missing hfp_slc_info_free function declaration.
---
 drivers/hfpmodem/slc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 825b8a9..3ac2b9e 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -84,6 +84,13 @@ done:
 	return info;
 }
 =

+void hfp_slc_info_free(struct hfp_slc_info *info)
+{
+	g_at_chat_unref(info->chat);
+
+	g_free(info);
+}
+
 static void slc_establish_data_unref(gpointer userdata)
 {
 	struct slc_establish_data *sed =3D userdata;
-- =

1.8.1.1


--===============1021973118407372322==--

