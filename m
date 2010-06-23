Content-Type: multipart/mixed; boundary="===============7771175946884090635=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stkutil: Alpha Id is optional for Select Item.
Date: Wed, 23 Jun 2010 06:13:50 +0200
Message-ID: <1277266430-31234-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7771175946884090635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c5eca3f..6f072e7 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2601,8 +2601,7 @@ static enum stk_command_parse_result parse_select_ite=
m(
 		return STK_PARSE_RESULT_DATA_NOT_UNDERSTOOD;
 =

 	status =3D parse_dataobj(iter,
-			STK_DATA_OBJECT_TYPE_ALPHA_ID,
-			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
+			STK_DATA_OBJECT_TYPE_ALPHA_ID, 0,
 			&obj->alpha_id,
 			STK_DATA_OBJECT_TYPE_ITEM,
 			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM |
-- =

1.7.1.86.g0e460.dirty


--===============7771175946884090635==--

