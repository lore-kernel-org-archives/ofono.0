Content-Type: multipart/mixed; boundary="===============3730510056564500951=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] Add mpty field to ofono_call
Date: Mon, 23 Nov 2009 14:06:53 +0800
Message-ID: <1258956413-14197-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3730510056564500951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A field 'mpty' is added to ofono_call so that we can know
whether the call belongs to multiparty call or not. According
to 27.007 7.18, it is a defined return value of AT+CLCC.
---
 drivers/atmodem/atutil.c |    4 +++-
 include/types.h          |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 3a365f4..c3d7922 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -115,6 +115,7 @@ GSList *at_util_parse_clcc(GAtResult *result)
 	GAtResultIter iter;
 	GSList *l =3D NULL;
 	int id, dir, status, type;
+	ofono_bool_t mpty;
 	struct ofono_call *call;
 =

 	g_at_result_iter_init(&iter, result);
@@ -135,7 +136,7 @@ GSList *at_util_parse_clcc(GAtResult *result)
 		if (!g_at_result_iter_next_number(&iter, &type))
 			continue;
 =

-		if (!g_at_result_iter_skip_next(&iter))
+		if (!g_at_result_iter_next_number(&iter, &mpty))
 			continue;
 =

 		if (g_at_result_iter_next_string(&iter, &str))
@@ -150,6 +151,7 @@ GSList *at_util_parse_clcc(GAtResult *result)
 		call->direction =3D dir;
 		call->status =3D status;
 		call->type =3D type;
+		call->mpty =3D mpty;
 		strncpy(call->phone_number.number, str,
 				OFONO_MAX_PHONE_NUMBER_LENGTH);
 		call->phone_number.type =3D number_type;
diff --git a/include/types.h b/include/types.h
index 6a9681d..79e6d4c 100644
--- a/include/types.h
+++ b/include/types.h
@@ -87,6 +87,7 @@ struct ofono_call {
 	int type;
 	int direction;
 	int status;
+	ofono_bool_t mpty;
 	struct ofono_phone_number phone_number;
 	int clip_validity;
 };
-- =

1.6.2.5


--===============3730510056564500951==--

