Content-Type: multipart/mixed; boundary="===============8374246994658370639=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] stk: Make sure to reset respond_on_exit.
Date: Mon, 28 Feb 2011 01:58:55 +0100
Message-ID: <1298854735-9305-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8374246994658370639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes a crash spotted by Lasse Kunnasluoto documented at
http://lists.ofono.org/pipermail/ofono/2011-February/009211.html
---
 src/stk.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index bc46b2f..c4e988b 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2514,6 +2514,7 @@ static void stk_proactive_command_cancel(struct ofono=
_stk *stk)
 		stk_command_free(stk->pending_cmd);
 		stk->pending_cmd =3D NULL;
 		stk->cancel_cmd =3D NULL;
+		stk->respond_on_exit =3D FALSE;
 	}
 }
 =

-- =

1.7.1.86.g0e460.dirty


--===============8374246994658370639==--

