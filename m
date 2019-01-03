Content-Type: multipart/mixed; boundary="===============8095907136167380134=="
MIME-Version: 1.0
From: BOUBAKER Bassem <bassem.boubaker@actia.fr>
Subject: [PATCH] plugins/udevng.c : Add support for cinterion PXS8 ACM mode
Date: Thu, 03 Jan 2019 13:04:40 +0000
Message-ID: <1546520666-11447-1-git-send-email-bassem.boubaker@actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8095907136167380134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This module can be enumerated in 2 modes. The first is ttyUSB* (currently s=
upported by ofono).
The second mode is that interfaces appears as ttyACM* . This implies enumer=
ation using different pid.
---
 plugins/udevng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff6e1fc..68d1748 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1685,6 +1685,7 @@ static struct {
 	{ "gemalto",	"option",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_wdm",	"1e2d",	"0053"	},
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
+	{ "gemalto",	"cdc_acm",	"1e2d",	"0054"  },
 	{ "gemalto",	"cdc_acm",	"1e2d",	"0061"	},
 	{ "gemalto",	"cdc_ether",	"1e2d",	"0061"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
-- =

2.7.4


--===============8095907136167380134==--

