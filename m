Content-Type: multipart/mixed; boundary="===============4500524885033064823=="
MIME-Version: 1.0
From: dragos@endocode.com
Subject: [PATCH 01/19] plugins/udevng: support the U-Blox TOBY-L2 series
Date: Wed, 09 Mar 2016 17:05:33 +0100
Message-ID: <1457539533-8913-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4500524885033064823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Dongsu Park <dongsu@endocode.com>

The newest generation of U-Blox TOBY-L2 series can be detected with
VID 0x1546 (the same as before), and one of the following PIDs:

* "0x1146" : high throughput profile
* "0x1141" : fairly back-compatible profile
* "0x1143" : low/medium throughput profile

This patch adds detection for high throughput mode.
---
 plugins/udevng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index e43d045..52b667e 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1120,6 +1120,8 @@ static struct {
 	{ "samsung",	"kalmia"			},
 	{ "quectel",	"option",	"05c6", "9090"	},
 	{ "ublox",	"cdc_acm",	"1546", "1102"	},
+	{ "ublox",	"rndis_host",	"1546", "1146"	},
+	{ "ublox",	"cdc_acm",	"1546", "1146"	},
 	{ }
 };
 =

-- =

2.5.0


--===============4500524885033064823==--

