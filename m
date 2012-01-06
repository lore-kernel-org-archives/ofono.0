Content-Type: multipart/mixed; boundary="===============4620933000110715183=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 1/3] udevng: Simplify vendor_list for Huawei constructor
Date: Fri, 06 Jan 2012 16:28:36 +0100
Message-ID: <1325863718-19357-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1325863718-19357-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4620933000110715183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to Huawei constructor, the port mapping is identical
for all the modems. We can decide to use GSM or CDMA drivers into
the plugin.
---
 plugins/udevng.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index ef20955..7d81416 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -793,11 +793,9 @@ static struct {
 	{ "hso",	"hso"				},
 	{ "gobi",	"qcserial"			},
 	{ "sierra",	"sierra"			},
-	{ "huawei",	"option",	"201e", "2009"	},
+	{ "huawei",	"option",	"201e"		},
 	{ "huawei",	"cdc_ether",	"12d1"		},
 	{ "huawei",	"option",	"12d1"		},
-	{ "huaweicdma",	"option",	"12d1", "140b"	},
-	{ "huaweicdma", "option",	"201e"		},
 	{ "speedupcdma","option",	"1c9e", "9e00"	},
 	{ "speedup",	"option",	"1c9e"		},
 	{ "speedup",	"option",	"2020"		},
-- =

1.7.1


--===============4620933000110715183==--

