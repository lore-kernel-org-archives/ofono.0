Content-Type: multipart/mixed; boundary="===============5309180297264458922=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 1/2] ussd: rise up buffer lenght for ussd strings
Date: Tue, 10 Apr 2012 17:35:04 +0200
Message-ID: <1334072105-32105-2-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1334072105-32105-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5309180297264458922==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some ZTE modems used to convert any ussd strings in UCS2,
and so the buffer length is double. Considering the limit of
182 characters, 364 will avoid crash.
---
 drivers/atmodem/ussd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/ussd.c b/drivers/atmodem/ussd.c
index 443251a..f5b38e2 100644
--- a/drivers/atmodem/ussd.c
+++ b/drivers/atmodem/ussd.c
@@ -106,7 +106,7 @@ static void cusd_parse(GAtResult *result, struct ofono_=
ussd *ussd)
 	const char *content;
 	int dcs;
 	enum sms_charset charset;
-	unsigned char msg[160];
+	unsigned char msg[364];
 	const unsigned char *msg_ptr =3D NULL;
 	long msg_len;
 =

-- =

1.7.5.4


--===============5309180297264458922==--

