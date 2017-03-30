Content-Type: multipart/mixed; boundary="===============1935528799067062725=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [RFC hwdb v1 20/28] telitqmi: drop unused device rule
Date: Thu, 30 Mar 2017 22:53:01 +0200
Message-ID: <20170330205309.25850-21-jonas@southpole.se>
In-Reply-To: <20170330205309.25850-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1935528799067062725==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The rule might match for some device but setup_telitqmi does not attempt
to do anything for interfaces that aren't driven by the qmi_wwan driver
so it's pointless.
---
 plugins/udevng.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 3aef447..d02cc6e 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1324,7 +1324,6 @@ static struct {
 	{ "telit",	"usbserial",	"1bc7"		},
 	{ "telit",	"option",	"1bc7"		},
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
-	{ "telitqmi",	"option",	"1bc7", "1201"	},
 	{ "quectel",	"option",	"05c6", "9090"	},
 	{ "telit",	"cdc_ncm",	"1bc7", "0036"	},
 	{ "telit",	"cdc_acm",	"1bc7", "0036"	},
-- =

2.9.3


--===============1935528799067062725==--

