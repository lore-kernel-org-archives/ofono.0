Content-Type: multipart/mixed; boundary="===============8046979648218962052=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/1] stk: Fix getenv failure case
Date: Wed, 23 Mar 2011 04:42:04 -0700
Message-ID: <1300880524-21559-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1300880524-21559-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8046979648218962052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 68b6240..94ad396 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2177,8 +2177,9 @@ static void get_lang(struct stk_response *rsp, struct=
 ofono_stk *stk)
 =

 	l =3D getenv("LANG");
 	if (l =3D=3D NULL) {
-		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
-		goto out;
+		l =3D "en";
+		ofono_warn("LANG environment variable not set"
+				" - defaulting to en");
 	}
 =

 	memcpy(lang, l, 2);
@@ -2187,7 +2188,6 @@ static void get_lang(struct stk_response *rsp, struct=
 ofono_stk *stk)
 	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
 	rsp->provide_local_info.language =3D lang;
 =

-out:
 	if (stk_respond(stk, rsp, stk_command_cb))
 		stk_command_cb(&failure, stk);
 }
-- =

1.7.0.4


--===============8046979648218962052==--

