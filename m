Content-Type: multipart/mixed; boundary="===============2559577690486614402=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 8/8] sms: remove check for impossible NULL condition
Date: Fri, 04 Feb 2011 17:40:38 -0200
Message-ID: <1296848438-5584-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296848438-5584-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2559577690486614402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

tx_next() must never be called with entry =3D=3D NULL and currently it
was already being dereferenced before making this check. Thus just
remove it.
---
 src/sms.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 212a470..be7132a5 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -675,9 +675,6 @@ static gboolean tx_next(gpointer user_data)
 =

 	sms->tx_source =3D 0;
 =

-	if (entry =3D=3D NULL)
-		return FALSE;
-
 	if (sms->registered =3D=3D FALSE)
 		return FALSE;
 =

-- =

1.7.4


--===============2559577690486614402==--

