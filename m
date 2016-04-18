Content-Type: multipart/mixed; boundary="===============6562379455893300261=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH 1/3] drivers/isimodem: fix GCC 6.0 errors
Date: Mon, 18 Apr 2016 13:45:34 +0200
Message-ID: <1460979936-18296-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6562379455893300261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Kuba Pawlak <kuba.t.pawlak@gmail.com>

-Werror=3Dmisleading-indentation
---
 drivers/isimodem/voicecall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 460e34e519a2c8bf5930f421b14e1c974cd49d63..d6d4ea37d66a646be305f8aefa6=
879b4cd8f0bab 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -1715,7 +1715,7 @@ static void isi_release_specific(struct ofono_voiceca=
ll *ovc, int id,
 =

 		if ((status->mode_info & CALL_MODE_ORIGINATOR))
 			cause =3D CALL_CAUSE_BUSY_USER_REQUEST;
-			break;
+		break;
 	}
 =

 	isi_call_release_req(ovc, id, CALL_CAUSE_TYPE_CLIENT, cause, cb, data);
-- =

1.9.3

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============6562379455893300261==--

