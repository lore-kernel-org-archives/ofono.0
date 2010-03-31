Content-Type: multipart/mixed; boundary="===============0381912529928856020=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Fix ampersand commands check
Date: Wed, 31 Mar 2010 06:57:33 +0200
Message-ID: <1270011453-6802-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0381912529928856020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Also remove a trailing tab.

---
 gatchat/gatserver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 031e542..839ebe4 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -570,9 +570,9 @@ static int get_basic_prefix_size(const char *buf)
 		/* All other cases it is a simple 1 character prefix */
 		return 1;
 	}
-	=

+
 	if (buf[0] =3D=3D '&') {
-		if (g_ascii_isalpha(buf[0] =3D=3D FALSE))
+		if (g_ascii_isalpha(buf[1]) =3D=3D FALSE)
 			return 0;
 =

 		return 2;
-- =

1.6.1


--===============0381912529928856020==--

