Content-Type: multipart/mixed; boundary="===============3239174006148729300=="
MIME-Version: 1.0
From: Lucas, GuillaumeX <guillaumex.lucas@intel.com>
Subject: [PATCH] stk: fix issue to avoid null pointer for alpha_id
Date: Wed, 08 Dec 2010 12:33:32 +0000
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D40188136D95EB8@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3239174006148729300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Guillaume Lucas <guillaumex.lucas@intel.com>

If a SET UP CALL proactive command with no alpha identifier
occurs, the alpha_id pointer will be set to NULL. This will
generate a crash in the stkagent with dbus function. To avoid
this we use an empty string if the alpha identifier is not
present in the command.
---
 src/stk.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/stk.c b/src/stk.c
index 7b39f7e..8c7cb8a 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1755,13 +1755,12 @@ static gboolean handle_command_set_up_call(const st=
ruct stk_command *cmd,
 		return TRUE;
 	}
 =

-	if (sc->alpha_id_usr_cfm) {
-		alpha_id =3D dbus_apply_text_attributes(sc->alpha_id_usr_cfm,
-							&sc->text_attr_usr_cfm);
-		if (alpha_id =3D=3D NULL) {
-			rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
-			return TRUE;
-		}
+	alpha_id =3D dbus_apply_text_attributes(sc->alpha_id_usr_cfm ?
+						sc->alpha_id_usr_cfm : "",
+						&sc->text_attr_usr_cfm);
+	if (alpha_id =3D=3D NULL) {
+		rsp->result.type =3D STK_RESULT_TYPE_DATA_NOT_UNDERSTOOD;
+		return TRUE;
 	}
 =

 	err =3D stk_agent_confirm_call(stk->current_agent, alpha_id,
-- =

1.7.0.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============3239174006148729300==--

