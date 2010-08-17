Content-Type: multipart/mixed; boundary="===============6602242524695331287=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCH v5 6/8] plugins/modemconf.c add support for Interface for STE
 plugin.
Date: Tue, 17 Aug 2010 14:22:32 +0200
Message-ID: <1282047754-15562-7-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1282047754-15562-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6602242524695331287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/modemconf.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/modemconf.c b/plugins/modemconf.c
index 3747cd9..d7b1354 100644
--- a/plugins/modemconf.c
+++ b/plugins/modemconf.c
@@ -138,6 +138,7 @@ static struct {
 	{ "g1",		set_device	},
 	{ "wavecom",	set_device	},
 	{ "ste",	set_device	},
+	{ "ste",	set_interface	},
 	{ "calypso",	set_device	},
 	{ "palmpre",	set_device	},
 	{ "isimodem",	set_interface	},
-- =

1.6.3.3


--===============6602242524695331287==--

