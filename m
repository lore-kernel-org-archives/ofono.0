Content-Type: multipart/mixed; boundary="===============2045088042884290800=="
MIME-Version: 1.0
From: Alfonso Sanchez-Beato <alfonso.sanchez-beato@canonical.com>
Subject: [PATCH 2/3] smsutil: Do not check the origin port
Date: Mon, 07 Sep 2015 11:58:16 +0200
Message-ID: <1441619897-22899-3-git-send-email-alfonso.sanchez-beato@canonical.com>
In-Reply-To: <1441619897-22899-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2045088042884290800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do not check if the origin port is reserved, as some operators use that
range of values.
---
 src/smsutil.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 9406a8a..19e2016 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -1946,9 +1946,6 @@ static gboolean extract_app_port_common(struct sms_ud=
h_iter *iter, int *dst,
 			if (((addr_hdr[0] << 8) | addr_hdr[1]) > 49151)
 				break;
 =

-			if (((addr_hdr[2] << 8) | addr_hdr[3]) > 49151)
-				break;
-
 			dstport =3D (addr_hdr[0] << 8) | addr_hdr[1];
 			srcport =3D (addr_hdr[2] << 8) | addr_hdr[3];
 			is_addr_8bit =3D FALSE;
-- =

2.1.4


--===============2045088042884290800==--

