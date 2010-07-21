Content-Type: multipart/mixed; boundary="===============5112389366260689656=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix: Free modem name in ofono_modem_remove
Date: Wed, 21 Jul 2010 14:41:14 +0800
Message-ID: <1279694474-10635-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5112389366260689656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Avoid the memory leak of modem name.
---
 src/modem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index ccbbc27..79a5d58 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -1495,6 +1495,7 @@ void ofono_modem_remove(struct ofono_modem *modem)
 	if (modem->driver_type)
 		g_free(modem->driver_type);
 =

+	g_free(modem->name);
 	g_free(modem->path);
 	g_free(modem);
 }
-- =

1.7.0.4


--===============5112389366260689656==--

