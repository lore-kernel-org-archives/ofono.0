Content-Type: multipart/mixed; boundary="===============6650082210364162822=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH] udevng: Remove huaweicdma label from driver_list
Date: Mon, 09 Jan 2012 11:30:13 +0100
Message-ID: <1326105013-31922-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6650082210364162822==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 7d81416..315b8af 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -606,7 +606,6 @@ static struct {
 	{ "gobi",	setup_gobi,	},
 	{ "sierra",	setup_sierra	},
 	{ "huawei",	setup_huawei	},
-	{ "huaweicdma",	setup_huawei	},
 	{ "speedupcdma",setup_speedup	},
 	{ "speedup",	setup_speedup	},
 	{ "linktop",	setup_linktop	},
-- =

1.7.1


--===============6650082210364162822==--

