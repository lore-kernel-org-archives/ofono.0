Content-Type: multipart/mixed; boundary="===============6761984838810494990=="
MIME-Version: 1.0
From: Anirudh Gargi <anirudh.gargi@intel.com>
Subject: [PATCH] atmodem: add EUTRAN tech for creg read status
Date: Thu, 27 Sep 2018 16:49:56 +0530
Message-ID: <1538047196-11843-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6761984838810494990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for CREG's status to get the technology type. CREG
notify URC does not need additional handling as 'AcT' is mapped
one-on-one to tech.
---
 drivers/atmodem/network-registration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 0854cd1..789397e 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -228,6 +228,10 @@ static void at_creg_cb(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	if ((status =3D=3D 1 || status =3D=3D 5) && (tech =3D=3D -1))
 		tech =3D nd->tech;
 =

+	/* 6-10 is EUTRAN, with 8 being emergency bearer case */
+	if((status > 5) && (tech =3D=3D -1))
+		tech =3D ACCESS_TECHNOLOGY_EUTRAN;
+
 	cb(&error, status, lac, ci, tech, cbd->data);
 }
 =

-- =

2.7.4


--===============6761984838810494990==--

