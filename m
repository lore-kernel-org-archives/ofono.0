Content-Type: multipart/mixed; boundary="===============2582306789635663775=="
MIME-Version: 1.0
From: Varun Gargi <varun.gargi@intel.com>
Subject: [PATCH] udevng: remove vendor ID to make it generic for intel modem
Date: Wed, 23 May 2018 10:59:00 +0530
Message-ID: <1527053340-1803-1-git-send-email-varun.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2582306789635663775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index cd56fd5..3bd6ffa 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1671,8 +1671,8 @@ static struct {
 	{ "gemalto",	"cdc_ether",	"1e2d",	"0061"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
 	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
-	{ "xmm7xxx",	"cdc_acm",	"8087", "0930"	},
-	{ "xmm7xxx",	"cdc_ncm",	"8087", "0930"	},
+	{ "xmm7xxx",	"cdc_acm",	"8087"		},
+	{ "xmm7xxx",	"cdc_ncm",	"8087"		},
 	{ }
 };
 =

-- =

1.9.1


--===============2582306789635663775==--

