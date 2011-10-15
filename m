Content-Type: multipart/mixed; boundary="===============3323720304106786392=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH] udevng: add a driver name for telit
Date: Sat, 15 Oct 2011 16:33:47 -0300
Message-ID: <1318707227-5187-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3323720304106786392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

telit hardware needs usbserial.
---
 plugins/udevng.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 5fd9475..02cccc3 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -811,7 +811,7 @@ static struct {
 	{ "alcatel",	"option",	"1bbb", "0017"	},
 	{ "novatel",	"option",	"1410"		},
 	{ "zte",	"option",	"19d2"		},
-	{ "telit",	"option",	"1bc7"		},
+	{ "telit",	"usbserial",	"1bc7"		},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
-- =

1.7.6.4


--===============3323720304106786392==--

