Content-Type: multipart/mixed; boundary="===============9001502231686944567=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] n900: remove unneeded g_isi_client_destroy call.
Date: Thu, 23 Dec 2010 05:39:40 +0100
Message-ID: <1293079181-13648-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1293079181-13648-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9001502231686944567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"client" is either NULL or uninitialised in this place.
---
 plugins/n900.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/n900.c b/plugins/n900.c
index 711f4ed..29daf05 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -382,7 +382,6 @@ static int n900_probe(struct ofono_modem *modem)
 	return 0;
 =

 error:
-	g_isi_client_destroy(client);
 	g_isi_modem_destroy(isimodem);
 	gpio_remove(modem);
 	g_free(isi);
-- =

1.7.1.86.g0e460.dirty


--===============9001502231686944567==--

