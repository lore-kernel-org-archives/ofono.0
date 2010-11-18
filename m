Content-Type: multipart/mixed; boundary="===============8655450959986635378=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/2] stk: provide access technology info
Date: Thu, 18 Nov 2010 18:55:55 +0800
Message-ID: <1290077756-28124-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1290077756-28124-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8655450959986635378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   14 +++++
 src/ofono.h   |    1 +
 src/stk.c     |  179 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 194 insertions(+), 0 deletions(-)

diff --git a/src/network.c b/src/network.c
index f1d7724..481ece8 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1852,3 +1852,17 @@ void *ofono_netreg_get_data(struct ofono_netreg *net=
reg)
 {
 	return netreg->driver_data;
 }
+
+unsigned int __ofono_netreg_get_tech(struct ofono_netreg *netreg)
+{
+	GSList *o;
+	unsigned int techs =3D 0;
+	struct network_operator_data *opd;
+
+	for (o =3D netreg->operator_list; o; o =3D o->next) {
+		opd =3D o->data;
+		techs |=3D opd->techs;
+	}
+
+	return techs;
+}
diff --git a/src/ofono.h b/src/ofono.h
index 4d76d20..c9d25ab 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -363,6 +363,7 @@ gboolean __ofono_netreg_remove_status_watch(struct ofon=
o_netreg *netreg,
 =

 void __ofono_netreg_set_base_station_name(struct ofono_netreg *netreg,
 						const char *name);
+unsigned int __ofono_netreg_get_tech(struct ofono_netreg *netreg);
 =

 #include <ofono/history.h>
 =

diff --git a/src/stk.c b/src/stk.c
index 18beee6..eec1ddf 100644
--- a/src/stk.c
+++ b/src/stk.c
@@ -1989,6 +1989,180 @@ static gboolean handle_command_refresh(const struct=
 stk_command *cmd,
 	return TRUE;
 }
 =

+static gboolean get_tech(struct ofono_stk *stk, struct stk_response *rsp,
+							gboolean singleton)
+{
+	struct ofono_atom *atom;
+	struct ofono_netreg *netreg;
+	unsigned int tech;
+	unsigned int tech_stk =3D 0;
+	unsigned int i;
+	int length =3D 0;
+	int length_temp =3D 0;
+	enum stk_access_technology_type *techs;
+	static struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_FAILURE =
};
+
+	atom =3D __ofono_modem_find_atom(__ofono_atom_get_modem(stk->atom),
+							OFONO_ATOM_TYPE_NETREG);
+	if (!atom || !__ofono_atom_get_registered(atom))
+		goto error;
+
+	netreg =3D __ofono_atom_get_data(atom);
+	tech =3D __ofono_netreg_get_tech(netreg);
+
+	if (tech =3D=3D 0)
+		goto error;
+
+	/* Stk has different definition of access technology, so do some map */
+	if (tech & ((1 << ACCESS_TECHNOLOGY_GSM) ||
+			(1 << ACCESS_TECHNOLOGY_GSM_COMPACT) ||
+			(1 << ACCESS_TECHNOLOGY_GSM_EGPRS))) {
+		tech_stk |=3D 1 << STK_ACCESS_TECHNOLOGY_GSM;
+		length++;
+
+		if (singleton && (length =3D=3D 1))
+			goto finish;
+	}
+
+	if (tech & ((1 << ACCESS_TECHNOLOGY_UTRAN) ||
+			(1 << ACCESS_TECHNOLOGY_UTRAN_HSDPA) ||
+			(1 << ACCESS_TECHNOLOGY_UTRAN_HSUPA) ||
+			(1 << ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA))) {
+		tech_stk |=3D 1 << STK_ACCESS_TECHNOLOGY_UTRAN;
+		length++;
+
+		if (singleton && (length =3D=3D 1))
+			goto finish;
+	}
+
+	if (tech & (1 << ACCESS_TECHNOLOGY_EUTRAN)) {
+		tech_stk |=3D 1 << STK_ACCESS_TECHNOLOGY_EUTRAN;
+		length++;
+	}
+
+finish:
+	if (length =3D=3D 0)
+		goto error;
+
+	techs =3D g_try_malloc(length);
+	if (!techs)
+		goto error;
+
+	for (i =3D 0; i < sizeof(tech_stk) * 8; i++)
+		if (tech_stk & (1 << i))
+			techs[length_temp++] =3D i;
+
+	rsp->provide_local_info.access_technologies.techs =3D techs;
+	rsp->provide_local_info.access_technologies.length =3D length;
+	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
+
+	if (stk_respond(stk, rsp, stk_command_cb))
+		stk_command_cb(&error, stk);
+
+	g_free(techs);
+	return FALSE;
+
+error:
+	rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+	return TRUE;
+}
+
+static gboolean handle_command_provide_local_info(const struct stk_command=
 *cmd,
+				struct stk_response *rsp, struct ofono_stk *stk)
+{
+	switch (cmd->qualifier) {
+	case 0:
+		DBG("Location Information");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 1:
+		DBG("IMEI");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 2:
+		DBG("Network Measurement results");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 3:
+		DBG("Date, time and time zone");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 4:
+		DBG("Language setting");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 5:
+		DBG("Timing Advance");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 6:
+		DBG("Access Technology");
+		return get_tech(stk, rsp, TRUE);
+
+	case 7:
+		DBG("ESN");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 8:
+		DBG("IMEISV");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 9:
+		DBG("Search Mode");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 10:
+		DBG("Charge State of the Battery");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 11:
+		DBG("MEID");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 12:
+		DBG("current WSID");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 13:
+		DBG("Broadcast Network information");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 14:
+		DBG("Multiple Access Technologies");
+		return get_tech(stk, rsp, FALSE);
+
+	case 15:
+		DBG("Location Information for multiple access technologies");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	case 16:
+		DBG("Network Measurement results for "
+					"multiple access technologies");
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+
+	default:
+		ofono_info("Undefined Provide Local Information qualifier: %d",
+				cmd->qualifier);
+		rsp->result.type =3D STK_RESULT_TYPE_NOT_CAPABLE;
+		return TRUE;
+	}
+}
+
 static void send_dtmf_cancel(struct ofono_stk *stk)
 {
 	struct ofono_voicecall *vc =3D NULL;
@@ -2421,6 +2595,11 @@ void ofono_stk_proactive_command_notify(struct ofono=
_stk *stk,
 							&rsp, stk);
 		break;
 =

+	case STK_COMMAND_TYPE_PROVIDE_LOCAL_INFO:
+		respond =3D handle_command_provide_local_info(stk->pending_cmd,
+								&rsp, stk);
+		break;
+
 	case STK_COMMAND_TYPE_SEND_DTMF:
 		respond =3D handle_command_send_dtmf(stk->pending_cmd,
 							&rsp, stk);
-- =

1.7.2.3


--===============8655450959986635378==--

