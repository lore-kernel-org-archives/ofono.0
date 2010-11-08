Content-Type: multipart/mixed; boundary="===============1345811315158964815=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] gprs: NULL-safe ofono_gprs_context_remove()
Date: Mon, 08 Nov 2010 20:41:07 +0200
Message-ID: <1289241667-25149-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1345811315158964815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Check for NULL in one place.
---
 src/gprs.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index 219bd4a..0f6fb0c 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2083,6 +2083,9 @@ struct ofono_gprs_context *ofono_gprs_context_create(=
struct ofono_modem *modem,
 =

 void ofono_gprs_context_remove(struct ofono_gprs_context *gc)
 {
+	if (gc =3D=3D NULL)
+		return;
+
 	__ofono_atom_free(gc->atom);
 }
 =

-- =

1.7.1


--===============1345811315158964815==--

