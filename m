Content-Type: multipart/mixed; boundary="===============8368214827054588743=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stkutil: Remove obsolete comment.
Date: Mon, 21 Jun 2010 10:41:11 +0200
Message-ID: <1277109671-7452-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1277109671-7452-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8368214827054588743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 642081e..6520c8a 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -4541,9 +4541,6 @@ static gboolean build_dataobj_bcch_channel_list(struc=
t stk_tlv_builder *tlv,
 	unsigned int i, bytes, pos, shift;
 	unsigned char value;
 =

-	/* To distinguish between no BCCH Channel List data object and
-	 * an empty object in a sequence of empty and non-empty objects,
-	 * .channels must be non-NULL in objects in sequences.  */
 	if (list->has_list =3D=3D FALSE)
 		return TRUE;
 =

-- =

1.7.1.86.g0e460.dirty


--===============8368214827054588743==--

