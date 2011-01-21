Content-Type: multipart/mixed; boundary="===============9117500698506278058=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] stk: change timeout from 10 to 3mintues
Date: Fri, 21 Jan 2011 10:04:25 -0800
Message-ID: <1295633065-13023-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9117500698506278058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 80edc25..29d2087 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -2839,7 +2839,7 @@ void ofono_stk_register(struct ofono_stk *stk)
 =

 	__ofono_atom_register(stk->atom, stk_unregister);
 =

-	stk->timeout =3D 600; /* 10 minutes */
+	stk->timeout =3D 180; /* 3 minutes */
 	stk->short_timeout =3D 20; /* 20 seconds */
 	stk->envelope_q =3D g_queue_new();
 }
-- =

1.7.0.4


--===============9117500698506278058==--

