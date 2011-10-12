Content-Type: multipart/mixed; boundary="===============5594098520466061939=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 19/19] hfp_hf: Switched to permissive AT syntax parser
Date: Wed, 12 Oct 2011 14:35:40 +0200
Message-ID: <1318422940-14955-20-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5594098520466061939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some phones can have trouble when using the strict AT syntax parser for
HFP. So far, this has only been evidenced with the Samsung Wave, which
works fine with the permissive syntax parser.

Several other phones have been tested with the permissive parser and
seem to work OK.
---
 plugins/hfp_hf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/hfp_hf.c b/plugins/hfp_hf.c
index 1008696..58ebc64 100644
--- a/plugins/hfp_hf.c
+++ b/plugins/hfp_hf.c
@@ -135,7 +135,7 @@ static int service_level_connection(struct ofono_modem =
*modem, int fd)
 		return -EIO;
 	}
 =

-	syntax =3D g_at_syntax_new_gsmv1();
+	syntax =3D g_at_syntax_new_gsm_permissive();
 	chat =3D g_at_chat_new(io, syntax);
 	g_at_syntax_unref(syntax);
 	g_io_channel_unref(io);
-- =

1.7.6.4


--===============5594098520466061939==--

