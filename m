Content-Type: multipart/mixed; boundary="===============8638696196613921397=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Fix remove unused variable data
Date: Tue, 02 Mar 2010 10:54:13 +0800
Message-ID: <1267498453-23962-1-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8638696196613921397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stkutil.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index 337868b..6a95cd2 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -188,7 +188,6 @@ static gboolean parse_dataobj_imm_resp(struct comprehen=
sion_tlv_iter *iter,
 					void *user)
 {
 	gboolean *resp =3D user;
-	const unsigned char *data;
 =

 	if (comprehension_tlv_iter_get_tag(iter) !=3D
 			STK_DATA_OBJECT_TYPE_IMMEDIATE_RESPONSE)
-- =

1.6.6.1


--===============8638696196613921397==--

