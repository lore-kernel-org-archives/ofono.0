Content-Type: multipart/mixed; boundary="===============8702910258696309473=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 2/8] hfpmodem: Add version defines for HFP 1.6
Date: Thu, 17 Jan 2013 12:13:05 -0300
Message-ID: <1358435591-14757-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1358435591-14757-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8702910258696309473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

---
 drivers/hfpmodem/slc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hfpmodem/slc.h b/drivers/hfpmodem/slc.h
index a9f42f7..b71ffe9 100644
--- a/drivers/hfpmodem/slc.h
+++ b/drivers/hfpmodem/slc.h
@@ -29,7 +29,8 @@
 =

 enum hfp_version {
 	HFP_VERSION_1_5 =3D	0x0105,
-	HFP_VERSION_LATEST =3D	HFP_VERSION_1_5,
+	HFP_VERSION_1_6 =3D	0x0106,
+	HFP_VERSION_LATEST =3D	HFP_VERSION_1_6,
 };
 =

 enum hfp_indicator {
-- =

1.7.11.7


--===============8702910258696309473==--

