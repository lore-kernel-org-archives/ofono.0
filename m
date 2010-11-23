Content-Type: multipart/mixed; boundary="===============7589111879581792619=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 3/7] text-telephony: add new interface to feature map
Date: Tue, 23 Nov 2010 16:04:14 -0200
Message-ID: <1290535458-18786-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1290535458-18786-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7589111879581792619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index cfc767e..f032d93 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -904,6 +904,7 @@ static const struct {
 	{ OFONO_SIM_MANAGER_INTERFACE,			"sim"	},
 	{ OFONO_STK_INTERFACE,				"stk"	},
 	{ OFONO_CONNECTION_MANAGER_INTERFACE,		"gprs"	},
+	{ OFONO_TEXT_TELEPHONY_INTERFACE,		"tty"	},
 	{ },
 };
 =

-- =

1.7.3.2


--===============7589111879581792619==--

