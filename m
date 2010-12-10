Content-Type: multipart/mixed; boundary="===============8727645359984449748=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5][RfC] stk: Partially handle Refresh command.
Date: Fri, 10 Dec 2010 14:59:24 +0100
Message-ID: <1291989564-28694-5-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1291989564-28694-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8727645359984449748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only the four "NAA initialisation" modes are handled at the moment.
---
 src/stk.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 09229ce..455bf35 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1951,6 +1951,10 @@ static gboolean handle_command_refresh(const struct =
stk_command *cmd,
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
@@ -2004,6 +2008,50 @@ static gboolean handle_command_refresh(const struct =
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
+		switch (qualifier) {
+		case 0:
+			__ofono_sim_refresh(sim, file_list, TRUE, TRUE);
+			break;
+		case 1:
+			__ofono_sim_refresh(sim, file_list, FALSE, FALSE);
+			break;
+		case 2:
+		case 3:
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


--===============8727645359984449748==--

