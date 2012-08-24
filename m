Content-Type: multipart/mixed; boundary="===============5887123799063411539=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 1/4] stk: check if immediate digit response is requested
Date: Fri, 24 Aug 2012 16:28:22 +0200
Message-ID: <1345818505-17175-2-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1345818505-17175-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5887123799063411539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/stk.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 7a7bd75..3883d11 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1519,6 +1519,7 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 	gboolean alphabet =3D (qualifier & (1 << 0)) !=3D 0;
 	gboolean ucs2 =3D (qualifier & (1 << 1)) !=3D 0;
 	gboolean yesno =3D (qualifier & (1 << 2)) !=3D 0;
+	gboolean immediate =3D (qualifier & (1 << 3)) !=3D 0;
 	/*
 	 * Note: immediate response and help parameter values are not
 	 * provided by current api.
@@ -1547,8 +1548,9 @@ static gboolean handle_command_get_inkey(const struct=
 stk_command *cmd,
 						timeout);
 	else
 		err =3D stk_agent_request_digit(stk->current_agent, text,
-						&gi->icon_id, request_key_cb,
-						stk, NULL, timeout);
+						&gi->icon_id, immediate,
+						request_key_cb, stk, NULL,
+						timeout);
 =

 	g_free(text);
 =

-- =

1.7.9.5


--===============5887123799063411539==--

