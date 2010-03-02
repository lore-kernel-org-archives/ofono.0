Content-Type: multipart/mixed; boundary="===============1068828440879291764=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/4] Fix remove wrong extended prefix
Date: Tue, 02 Mar 2010 18:21:37 +0800
Message-ID: <1267525299-5740-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267525299-5740-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1068828440879291764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ATA, ATH and ATD are belongs to basic command. So removed them.
---
 gatchat/gatserver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index c72e798..253a80a 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -216,7 +216,7 @@ static void server_parse_line(GAtServer *server, char *=
line)
 	if (c =3D=3D ';')
 		c =3D line[++i];
 =

-	if (is_at_command_prefix(c) || c =3D=3D 'A' || c =3D=3D 'D' || c =3D=3D '=
H')
+	if (is_at_command_prefix(c))
 		parse_at_command(server, line + i);
 	else if (g_ascii_isalpha(c) || c =3D=3D '&')
 		parse_v250_settings(server, line + i);
-- =

1.6.6.1


--===============1068828440879291764==--

