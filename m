Content-Type: multipart/mixed; boundary="===============4769264842376694122=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 1/2] Fix use of uninitialized variable
Date: Tue, 02 Feb 2010 20:08:29 -0200
Message-ID: <1265148510-24408-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4769264842376694122==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatchat.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index e25bfd6..5b0851b 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -692,7 +692,7 @@ static gboolean received_data(GIOChannel *channel, GIOC=
ondition cond,
 	unsigned char *buf;
 	GAtChat *chat =3D data;
 	GIOError err;
-	gsize rbytes;
+	gsize rbytes =3D 0;
 	gsize toread;
 	gsize total_read =3D 0;
 	guint read_count =3D 0;
-- =

1.6.4.4


--===============4769264842376694122==--

