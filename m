Content-Type: multipart/mixed; boundary="===============4033466728919112112=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 3/4] stk: Ask for immediate digit response if specified by
 command qualifier
Date: Tue, 28 Aug 2012 15:21:21 +0200
Message-ID: <1346160082-11077-4-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1346160082-11077-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4033466728919112112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 7a7bd75..38f2e18 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1519,9 +1519,9 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
 	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
 	gboolean yesno =3D (qualifier & (1 << 2)) !=3D 0;
+	gboolean immediate =3D (qualifier & (1 << 3)) !=3D 0;
 	/*
-	 * Note: immediate response and help parameter values are not
-	 * provided by current api.
+	 * Note: help parameter value is not provided by current api.
 	 */
 	int err;
 =

@@ -1545,6 +1545,11 @@ static gboolean handle_command_get_inkey(const struc=
t stk_command *cmd,
 						&gi->icon_id, ucs2,
 						request_key_cb, stk, NULL,
 						timeout);
+	else if (immediate)
+		err =3D stk_agent_request_quick_digit(stk->current_agent,
+							text, &gi->icon_id,
+							request_key_cb, stk,
+							NULL, timeout);
 	else
 		err =3D stk_agent_request_digit(stk->current_agent, text,
 						&gi->icon_id, request_key_cb,
-- =

1.7.9.5


--===============4033466728919112112==--

