Content-Type: multipart/mixed; boundary="===============5095934072591559616=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 5/6] unit: Add delivery_report to send_req testing
Date: Tue, 12 Jun 2012 16:04:14 +0200
Message-ID: <1339509855-7467-6-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1339509855-7467-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5095934072591559616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-mmsutil.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/unit/test-mmsutil.c b/unit/test-mmsutil.c
index 30a6c6c..4efbbcc 100644
--- a/unit/test-mmsutil.c
+++ b/unit/test-mmsutil.c
@@ -935,6 +935,7 @@ static const struct mms_encode_test mms_m_send_req_test=
_1 =3D {
 		{.sr =3D {
 			.status =3D MMS_MESSAGE_STATUS_DRAFT,
 			.to =3D "0123456789",
+			.dr =3D TRUE,
 			.content_type =3D CT_MULTIPART_MIXED,
 		} }
 	},
@@ -942,7 +943,7 @@ static const struct mms_encode_test mms_m_send_req_test=
_1 =3D {
 			0x36, 0x37, 0x38, 0x39, 0x61, 0x62, 0x63, 0x64, 0x65,
 			0x66, 0x5F, 0x73, 0x72, 0x31, 0x00, 0x8D, 0x92, 0x89,
 			0x01, 0x81, 0x97, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35,
-			0x36, 0x37, 0x38, 0x39, 0x00, 0x84, 0xA3
+			0x36, 0x37, 0x38, 0x39, 0x00, 0x86, 0x80, 0x84, 0xA3
 	}
 };
 =

-- =

1.7.4.1


--===============5095934072591559616==--

