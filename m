Content-Type: multipart/mixed; boundary="===============1072072140893843029=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 5/5] udevng: Simplify vendor and driver list for SpeedUp
Date: Mon, 09 Jan 2012 14:11:00 +0100
Message-ID: <1326114660-10111-6-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1326114660-10111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1072072140893843029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 315b8af..3dd48d5 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -606,7 +606,6 @@ static struct {
 	{ "gobi",	setup_gobi,	},
 	{ "sierra",	setup_sierra	},
 	{ "huawei",	setup_huawei	},
-	{ "speedupcdma",setup_speedup	},
 	{ "speedup",	setup_speedup	},
 	{ "linktop",	setup_linktop	},
 	{ "alcatel",	setup_alcatel	},
@@ -795,7 +794,6 @@ static struct {
 	{ "huawei",	"option",	"201e"		},
 	{ "huawei",	"cdc_ether",	"12d1"		},
 	{ "huawei",	"option",	"12d1"		},
-	{ "speedupcdma","option",	"1c9e", "9e00"	},
 	{ "speedup",	"option",	"1c9e"		},
 	{ "speedup",	"option",	"2020"		},
 	{ "alcatel",	"option",	"1bbb", "0017"	},
-- =

1.7.1


--===============1072072140893843029==--

