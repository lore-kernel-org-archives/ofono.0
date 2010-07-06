Content-Type: multipart/mixed; boundary="===============7859680186356440770=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/14] sktutil: Use the Mandatory flag in parse_dataobj.
Date: Wed, 07 Jul 2010 00:39:06 +0200
Message-ID: <1278455949-2823-12-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7859680186356440770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We need to look at the Mandatory flag and not at the Minimum flag
when parsing CTLVs.  The Minimum flag is important when encoding CTLVs
because CR bit is set according to it.
---
 src/stkutil.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index e92add3..d2cd126 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2324,8 +2324,8 @@ static enum stk_command_parse_result parse_dataobj(
 			if (comprehension_tlv_iter_get_tag(iter) =3D=3D entry->type)
 				break;
 =

-			/* Can't skip over Minimum objects */
-			if (entry->flags & DATAOBJ_FLAG_MINIMUM) {
+			/* Can't skip over mandatory objects */
+			if (entry->flags & DATAOBJ_FLAG_MANDATORY) {
 				l2 =3D NULL;
 				break;
 			}
@@ -2352,7 +2352,7 @@ static enum stk_command_parse_result parse_dataobj(
 	for (; l; l =3D l->next) {
 		struct dataobj_handler_entry *entry =3D l->data;
 =

-		if (entry->flags & DATAOBJ_FLAG_MINIMUM)
+		if (entry->flags & DATAOBJ_FLAG_MANDATORY)
 			minimum_set =3D FALSE;
 	}
 =

-- =

1.7.1.86.g0e460.dirty


--===============7859680186356440770==--

