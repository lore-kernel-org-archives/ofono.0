Content-Type: multipart/mixed; boundary="===============6840103465905668925=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] stkutil: Add typo/cleaning modifications
Date: Wed, 30 Mar 2011 23:39:38 +0200
Message-ID: <1301521178-12152-1-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6840103465905668925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    4 ++--
 src/stkutil.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index c64cb7a..3418b4b 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -5493,7 +5493,7 @@ const unsigned char *stk_pdu_from_response(const stru=
ct stk_response *response,
 	 * Min =3D N.
 	 *
 	 * However comprehension required is set for many of the TLVs in
-	 * TS 102 384 conformace tests so we set it per command and per
+	 * TS 102 384 conformance tests so we set it per command and per
 	 * data object type.
 	 */
 	tag =3D STK_DATA_OBJECT_TYPE_DEVICE_IDENTITIES;
@@ -6269,7 +6269,7 @@ char *stk_image_to_xpm(const unsigned char *img, unsi=
gned int len,
 =

 	/*
 	 * space needed:
-	 * 	header line
+	 *	header line
 	 *	declaration and beginning of assignment line
 	 *	values - max length of 19
 	 *	colors - ncolors * (cpp + whitespace + deliminators + color)
diff --git a/src/stkutil.h b/src/stkutil.h
index f2df23f..1b38dec 100644
--- a/src/stkutil.h
+++ b/src/stkutil.h
@@ -245,7 +245,7 @@ enum stk_result_type {
 	STK_RESULT_TYPE_USER_REJECT =3D			0x22,
 	STK_RESULT_TYPE_USER_CANCEL =3D			0x23,
 	STK_RESULT_TYPE_TIMER_CONFLICT =3D		0x24,
-	STK_RESULT_TYPE_CALL_CONTROL_TEMPORARY =3D 	0x25,
+	STK_RESULT_TYPE_CALL_CONTROL_TEMPORARY =3D	0x25,
 	STK_RESULT_TYPE_BROWSER_TEMPORARY =3D		0x26,
 	STK_RESULT_TYPE_MMS_TEMPORARY =3D			0x27,
 =

-- =

1.7.1


--===============6840103465905668925==--

