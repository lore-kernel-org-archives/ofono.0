Content-Type: multipart/mixed; boundary="===============0313417465010384295=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 1/2] stk: fix issue with null data object
Date: Mon, 07 Mar 2011 07:35:49 -0800
Message-ID: <1299512150-19314-2-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1299512150-19314-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0313417465010384295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As per the specification, if alphad identifier is
provided and is a null data object, no information
should be given to the user.
---
 src/stk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index e933e4e..3d736dd 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -484,7 +484,7 @@ static void stk_alpha_id_set(struct ofono_stk *stk,
 	 * and no alpha identifier cases equally. This may be changed once
 	 * better idea is found out.
 	 */
-	if (alpha !=3D NULL)
+	if (alpha !=3D NULL && alpha[0] !=3D '\0')
 		stk_agent_display_action_info(stk->current_agent, alpha, icon);
 =

 	g_free(alpha);
-- =

1.7.0.4


--===============0313417465010384295==--

