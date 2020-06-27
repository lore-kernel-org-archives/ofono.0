Content-Type: multipart/mixed; boundary="===============0301556285430524671=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 1/2] plugins: udevng: detect Centirion ELS81x modem
Date: Sat, 27 Jun 2020 14:08:37 +0300
Message-ID: <20200627110838.808865-2-geomatsi@gmail.com>
In-Reply-To: <20200627110838.808865-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0301556285430524671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Enable detection of Centirion ELS81x modem.

---
 plugins/udevng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 4a38621b..30597d2c 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1807,6 +1807,8 @@ static struct {
 	{ "gemalto",	"qmi_wwan",	"1e2d",	"0053"	},
 	{ "gemalto",	"cdc_acm",	"1e2d",	"0061"	},
 	{ "gemalto",	"cdc_ether",	"1e2d",	"0061"	},
+	{ "gemalto",	"cdc_acm",	"1e2d",	"005b"	},
+	{ "gemalto",	"cdc_ether",	"1e2d",	"005b"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
 	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
 	{ "xmm7xxx",	"cdc_acm",	"8087"		},
-- =

2.27.0

--===============0301556285430524671==--

