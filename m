Content-Type: multipart/mixed; boundary="===============0102679441119189685=="
MIME-Version: 1.0
From: christopher.vogl@hale.at
Subject: [PATCH 1/2] netreg: Query and select supported CMER modes
Date: Thu, 06 Sep 2012 11:25:28 +0200
Message-ID: <1346923528-32138-2-git-send-email-christopher.vogl@hale.at>
In-Reply-To: <1346923528-32138-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0102679441119189685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christopher Vogl <christopher.vogl@hale.at>

---
 drivers/atmodem/network-registration.c |  153 ++++++++++++++++++++++++++++=
+++-
 1 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index 3d09913..7160679 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -47,6 +47,7 @@ static const char *creg_prefix[] =3D { "+CREG:", NULL };
 static const char *cops_prefix[] =3D { "+COPS:", NULL };
 static const char *csq_prefix[] =3D { "+CSQ:", NULL };
 static const char *cind_prefix[] =3D { "+CIND:", NULL };
+static const char *cmer_prefix[] =3D { "+CMER:", NULL };
 static const char *zpas_prefix[] =3D { "+ZPAS:", NULL };
 static const char *option_tech_prefix[] =3D { "_OCTI:", "_OUWCTI:", NULL };
 =

@@ -1395,6 +1396,154 @@ notify:
 	ofono_netreg_status_notify(netreg, status, lac, ci, tech);
 }
 =

+static void at_cmer_not_supported(struct ofono_netreg *netreg)
+{
+	ofono_error("+CMER not supported by this modem.  If this is an error"
+			" please submit patches to support this hardware");
+}
+
+static void at_cmer_set_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
+{
+	struct ofono_netreg *netreg =3D user_data;
+
+	if (!ok)
+		at_cmer_not_supported(netreg);
+}
+
+static inline char wanted_cmer(int supported, const char *pref)
+{
+	while (*pref) {
+		if (supported & (1 << (*pref - '0')))
+			return *pref;
+
+		pref++;
+	}
+
+	return '\0';
+}
+
+static inline ofono_bool_t append_cmer_element(char *buf, int *len, int ca=
p,
+						const char *wanted,
+						ofono_bool_t last)
+{
+	char setting =3D wanted_cmer(cap, wanted);
+
+	if (!setting)
+		return FALSE;
+
+	buf[*len] =3D setting;
+
+	if (last)
+		buf[*len + 1] =3D '\0';
+	else
+		buf[*len + 1] =3D ',';
+
+	*len +=3D 2;
+
+	return TRUE;
+}
+
+static ofono_bool_t build_cmer_string(char *buf, int *cmer_opts,
+					struct netreg_data *nd)
+{
+	const char *mode;
+	int len =3D sprintf(buf, "AT+CMER=3D");
+
+	DBG("");
+
+	/*
+	 * Forward unsolicited result codes directly to the TE;
+	 * TA=E2=80=91TE link specific inband technique used to embed result code=
s and
+	 * data when TA is in on=E2=80=91line data mode
+	 */
+	if (!append_cmer_element(buf, &len, cmer_opts[0], "3", FALSE))
+		return FALSE;
+
+	/* No keypad event reporting */
+	if (!append_cmer_element(buf, &len, cmer_opts[1], "0", FALSE))
+		return FALSE;
+
+	/* No display event reporting */
+	if (!append_cmer_element(buf, &len, cmer_opts[2], "0", FALSE))
+		return FALSE;
+
+	switch (nd->vendor) {
+	case OFONO_VENDOR_TELIT:
+		/*
+		 * Telit does not support mode 1.
+		 * All indicator events shall be directed from TA to TE.
+		 */
+		mode =3D "2";
+		break;
+	default:
+		/*
+		 * Only those indicator events, which are not caused by +CIND
+		 * shall be indicated by the TA to the TE.
+		 */
+		mode =3D "1";
+		break;
+	}
+
+	/*
+	 * Indicator event reporting using URC +CIEV:=C2=A0<ind>,<value>.
+	 * <ind> indicates the indicator order number (as specified for +CIND)
+	 * and <value> is the new value of indicator.
+	 */
+	if (!append_cmer_element(buf, &len, cmer_opts[3], mode, TRUE))
+		return FALSE;
+
+	return TRUE;
+}
+
+static void at_cmer_query_cb(ofono_bool_t ok, GAtResult *result,
+				gpointer user_data)
+{
+	struct ofono_netreg *netreg =3D user_data;
+	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
+	GAtResultIter iter;
+	int cmer_opts_cnt =3D 5; /* See 27.007 Section 8.10 */
+	int cmer_opts[cmer_opts_cnt];
+	int opt;
+	int mode;
+	char buf[128];
+
+	if (!ok)
+		goto error;
+
+	memset(cmer_opts, 0, sizeof(cmer_opts));
+
+	g_at_result_iter_init(&iter, result);
+
+	if (!g_at_result_iter_next(&iter, "+CMER:"))
+		goto error;
+
+	for (opt =3D 0; opt < cmer_opts_cnt; opt++) {
+		int min, max;
+
+		if (!g_at_result_iter_open_list(&iter))
+			goto error;
+
+		while (g_at_result_iter_next_range(&iter, &min, &max)) {
+			for (mode =3D min; mode <=3D max; mode++)
+				cmer_opts[opt] |=3D 1 << mode;
+		}
+
+		if (!g_at_result_iter_close_list(&iter))
+			goto error;
+	}
+
+	if (build_cmer_string(buf, cmer_opts, nd) =3D=3D FALSE)
+		goto error;
+
+	g_at_chat_send(nd->chat, buf, cmer_prefix,
+			at_cmer_set_cb, netreg, NULL);
+
+	return;
+
+error:
+	at_cmer_not_supported(netreg);
+}
+
 static void cind_support_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
 {
 	struct ofono_netreg *netreg =3D user_data;
@@ -1465,8 +1614,8 @@ static void cind_support_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
 	if (nd->signal_index =3D=3D 0)
 		goto error;
 =

-	g_at_chat_send(nd->chat, "AT+CMER=3D3,0,0,1", NULL,
-			NULL, NULL, NULL);
+	g_at_chat_send(nd->chat, "AT+CMER=3D?", cmer_prefix,
+				at_cmer_query_cb, netreg, NULL);
 	g_at_chat_register(nd->chat, "+CIEV:",
 				ciev_notify, FALSE, netreg, NULL);
 	g_at_chat_register(nd->chat, "+CREG:",
-- =

1.7.7.6


--===============0102679441119189685==--

