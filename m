Content-Type: multipart/mixed; boundary="===============4567819059765083144=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 09/11] Fix do not emit error if extended error has emitted
Date: Wed, 17 Mar 2010 22:30:39 +0800
Message-ID: <1268836241-4834-9-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268836241-4834-8-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4567819059765083144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index c17a7b5..b0138d6 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -165,6 +165,10 @@ static void g_at_server_send_final(GAtServer *server, =
GAtServerResult result)
 	char r =3D v250.s4;
 	unsigned int len;
 =

+	/* Do not emit error if extended error has already been emitted */
+	if (result =3D=3D G_AT_SERVER_RESULT_EXT_ERROR)
+		return;
+
 	if (v250.quiet)
 		return;
 =

-- =

1.6.6.1


--===============4567819059765083144==--

