Content-Type: multipart/mixed; boundary="===============7184492660990997422=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v1 07/10] hfpmodem: Implement hfp_slc_info_free()
Date: Wed, 23 Jan 2013 15:27:58 -0300
Message-ID: <1358965681-7420-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1358965681-7420-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7184492660990997422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add missing hfp_slc_info_free() function declaration.
---
 drivers/hfpmodem/slc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
index 825b8a9..bf8d02d 100644
--- a/drivers/hfpmodem/slc.c
+++ b/drivers/hfpmodem/slc.c
@@ -84,6 +84,16 @@ done:
 	return info;
 }
 =

+void hfp_slc_info_free(struct hfp_slc_info *info)
+{
+	if (info =3D=3D NULL)
+		return;
+
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


--===============7184492660990997422==--

