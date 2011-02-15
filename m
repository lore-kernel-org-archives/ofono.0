Content-Type: multipart/mixed; boundary="===============6603462366863219431=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 9/9] stk: Partially handle Refresh command.
Date: Tue, 15 Feb 2011 08:58:59 +0100
Message-ID: <1297756739-2958-9-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1297756739-2958-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6603462366863219431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only the four "NAA initialisation" modes are handled at the moment.
---
 src/stk.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 199e02b..bc46b2f 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1973,10 +1973,22 @@ static gboolean handle_command_send_ussd(const stru=
ct stk_command *cmd,
 	return FALSE;
 }
 =

+static void free_idle_mode_text(struct ofono_stk *stk)
+{
+	g_free(stk->idle_mode_text);
+	stk->idle_mode_text =3D NULL;
+
+	memset(&stk->idle_mode_icon, 0, sizeof(stk->idle_mode_icon));
+}
+
 static gboolean handle_command_refresh(const struct stk_command *cmd,
 					struct stk_response *rsp,
 					struct ofono_stk *stk)
 {
+	struct ofono_error failure =3D { .type =3D OFONO_ERROR_TYPE_FAILURE };
+	struct ofono_sim *sim =3D NULL;
+	struct ofono_atom *sim_atom;
+	int err;
 	GSList *l;
 =

 	DBG("");
@@ -2030,6 +2042,59 @@ static gboolean handle_command_refresh(const struct =
stk_command *cmd,
 					cmd->refresh.icon_id.qualifier);
 	DBG("Alpha ID: %s", cmd->refresh.alpha_id);
 =

+	sim_atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
+						OFONO_ATOM_TYPE_SIM);
+	if (sim_atom)
+		sim =3D __ofono_atom_get_data(sim_atom);
+
+	if (sim =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+
+	if (cmd->qualifier < 4) {
+		int qualifier =3D stk->pending_cmd->qualifier;
+		GSList *file_list =3D stk->pending_cmd->refresh.file_list;
+
+		/* Don't free the list yet */
+		stk->pending_cmd->refresh.file_list =3D NULL;
+
+		/*
+		 * Queue the TERMINAL RESPONSE before triggering potential
+		 * file accesses.
+		 */
+		err =3D stk_respond(stk, rsp, stk_command_cb);
+		if (err)
+			stk_command_cb(&failure, stk);
+
+		/* TODO: use the alphaId / icon */
+		/* TODO: if AID is supplied, check its value */
+		/* TODO: possibly check if a D-bus call is pending or
+		 * an STK session ongoing. */
+
+		/* TODO: free some elements of the atom state */
+
+		switch (qualifier) {
+		case 0:
+			free_idle_mode_text(stk);
+			__ofono_sim_refresh(sim, file_list, TRUE, TRUE);
+			break;
+		case 1:
+			__ofono_sim_refresh(sim, file_list, FALSE, FALSE);
+			break;
+		case 2:
+		case 3:
+			free_idle_mode_text(stk);
+			__ofono_sim_refresh(sim, file_list, FALSE, TRUE);
+			break;
+		}
+
+		g_slist_foreach(file_list, (GFunc) g_free, NULL);
+		g_slist_free(file_list);
+
+		return FALSE;
+	}
+
 	rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
 	return TRUE;
 }
-- =

1.7.1.86.g0e460.dirty


--===============6603462366863219431==--

