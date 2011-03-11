Content-Type: multipart/mixed; boundary="===============7209683313295937971=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stk: fix issue with null data object
Date: Fri, 11 Mar 2011 10:39:59 +0100
Message-ID: <1299836399-23233-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7209683313295937971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will let the caller correctly detect NULL alpha id.
---
 src/stkutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index abd1c99..c64cb7a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -309,7 +309,7 @@ static gboolean parse_dataobj_alpha_id(struct comprehen=
sion_tlv_iter *iter,
 =

 	len =3D comprehension_tlv_iter_get_length(iter);
 	if (len =3D=3D 0) {
-		*alpha_id =3D g_try_malloc0(1);
+		*alpha_id =3D NULL;
 		return TRUE;
 	}
 =

-- =

1.7.1.86.g0e460.dirty


--===============7209683313295937971==--

