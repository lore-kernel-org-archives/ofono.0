Content-Type: multipart/mixed; boundary="===============4734304153388156597=="
MIME-Version: 1.0
From: Christopher.Vogl@hale.at
Subject: [PATCH] udev: add another driver name for telit
Date: Thu, 15 Dec 2011 15:43:01 +0100
Message-ID: <1323960181-15049-1-git-send-email-Christopher.Vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4734304153388156597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christopher Vogl <christopher.vogl@hale.at>

some telit hardware needs option driver.
---
 plugins/udevng.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index be87320..e062db3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -812,6 +812,7 @@ static struct {
 	{ "novatel",	"option",	"1410"		},
 	{ "zte",	"option",	"19d2"		},
 	{ "telit",	"usbserial",	"1bc7"		},
+	{ "telit",	"option",	"1bc7"		},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
-- =

1.7.4.4



--
Scanned by MailScanner.


--===============4734304153388156597==--

