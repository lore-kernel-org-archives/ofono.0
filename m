Content-Type: multipart/mixed; boundary="===============4999562795701160064=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/6] stkutil: Fix the assignment to minimum set
Date: Mon, 26 Apr 2010 18:29:21 +0800
Message-ID: <1272277766-25432-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4999562795701160064==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index a457e36..b4279c1 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2053,7 +2053,7 @@ static gboolean parse_dataobj(struct comprehension_tl=
v_iter *iter,
 =

 		if ((entry->flags & DATAOBJ_FLAG_MINIMUM) &&
 				entry->parsed =3D=3D FALSE)
-			minimum_set =3D TRUE;
+			minimum_set =3D FALSE;
 	}
 =

 	g_slist_foreach(entries, (GFunc)g_free, NULL);
-- =

1.7.0.4


--===============4999562795701160064==--

