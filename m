Content-Type: multipart/mixed; boundary="===============6431745262466937636=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] udevng: use huaweicdma driver for olive V-ME101
Date: Fri, 18 Nov 2011 13:27:43 +0100
Message-ID: <1321619263-28308-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6431745262466937636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index be87320..8d478cf 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -800,11 +800,10 @@ static struct {
 	{ "hso",	"hso"				},
 	{ "gobi",	"qcserial"			},
 	{ "sierra",	"sierra"			},
-	{ "huawei",	"option",	"201e", "2009"	},
+	{ "huaweicdma",	"option",	"201e", "2009"	},
 	{ "huawei",	"cdc_ether",	"12d1"		},
 	{ "huawei",	"option",	"12d1"		},
 	{ "huaweicdma",	"option",	"12d1", "140b"	},
-	{ "huaweicdma", "option",	"201e"		},
 	{ "speedupcdma","option",	"1c9e", "9e00"	},
 	{ "speedup",	"option",	"1c9e"		},
 	{ "speedup",	"option",	"2020"		},
-- =

1.7.4.1


--===============6431745262466937636==--

