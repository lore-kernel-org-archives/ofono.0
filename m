Content-Type: multipart/mixed; boundary="===============9202035607522947473=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] ussd: Fix crash with long ussd string
Date: Fri, 30 Mar 2012 15:16:36 +0200
Message-ID: <1333113396-1158-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9202035607522947473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some ZTE modem convert USSD string into UCS2 without respecting
the limitation of 160 bytes. So cut off the string if greater than
this limit
---
 drivers/atmodem/ussd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 443251a..bdee2d9 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -158,7 +158,7 @@ static void cusd_parse(GAtResult *result, struct ofono_=
ussd *ussd)
 =

 	case SMS_CHARSET_8BIT:
 	case SMS_CHARSET_UCS2:
-		msg_ptr =3D decode_hex_own_buf(content, -1, &msg_len, 0, msg);
+		msg_ptr =3D decode_hex_own_buf(content, 320, &msg_len, 0, msg);
 		break;
 	}
 =

-- =

1.7.5.4


--===============9202035607522947473==--

