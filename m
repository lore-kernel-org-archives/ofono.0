Content-Type: multipart/mixed; boundary="===============4991568662542391202=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 4/5] ppp: use common code to get options from pppcp packet data
Date: Fri, 26 Mar 2010 18:34:29 -0700
Message-ID: <1269653670-31352-5-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269653670-31352-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4991568662542391202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_cp.c |   71 ++++++++++++++++++++++++++++++--------------------=
---
 1 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 263fa8b..d7d70b7 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -1140,6 +1140,22 @@ static void remove_config_option(gpointer elem, gpoi=
nter user_data)
 	data->config_options =3D g_list_delete_link(data->config_options, list);
 }
 =

+static struct ppp_option *extract_ppp_option(guint8 *packet_data)
+{
+	struct ppp_option *option;
+	guint8 otype =3D packet_data[0];
+	guint8 olen =3D packet_data[1];
+
+	option =3D g_try_malloc0(olen);
+	if (option =3D=3D NULL)
+		return NULL;
+
+	option->type =3D otype;
+	option->length =3D olen;
+	memcpy(option->data, &packet_data[2], olen-2);
+	return option;
+}
+
 static guint8 pppcp_process_configure_request(struct pppcp_data *data,
 					struct pppcp_packet *packet)
 {
@@ -1157,14 +1173,13 @@ static guint8 pppcp_process_configure_request(struc=
t pppcp_data *data,
 	 * check the options.
 	 */
 	while (i < len) {
-		guint8 otype =3D packet->data[i];
-		guint8 olen =3D packet->data[i+1];
-		option =3D g_try_malloc0(olen);
+		option =3D extract_ppp_option(&packet->data[i]);
 		if (option =3D=3D NULL)
 			break;
-		option->type =3D otype;
-		option->length =3D olen;
-		memcpy(option->data, &packet->data[i+2], olen-2);
+
+		/* skip ahead to the next option */
+		i +=3D option->length;
+
 		if (action->option_scan)
 			rval =3D action->option_scan(option, data);
 		switch (rval) {
@@ -1182,10 +1197,9 @@ static guint8 pppcp_process_configure_request(struct=
 pppcp_data *data,
 						option);
 			break;
 		case OPTION_ERR:
-			g_printerr("unhandled option type %d\n", otype);
+			g_printerr("unhandled option type %d\n", option->type);
+			g_free(option);
 		}
-		/* skip ahead to the next option */
-		i +=3D olen;
 	}
 =

 	/* make sure all required config options were included */
@@ -1242,16 +1256,12 @@ static guint8 pppcp_process_configure_ack(struct pp=
pcp_data *data,
 	 * and apply them.
 	 */
 	while (i < len) {
-		guint8 otype =3D packet->data[i];
-		guint8 olen =3D packet->data[i + 1];
-		acked_option =3D g_try_malloc0(olen);
+		acked_option =3D extract_ppp_option(&packet->data[i]);
 		if (acked_option =3D=3D NULL)
 			break;
-		acked_option->type =3D otype;
-		acked_option->length =3D olen;
-		memcpy(acked_option->data, &packet->data[i + 2], olen - 2);
 		list =3D g_list_find_custom(data->config_options,
-				GUINT_TO_POINTER((guint) otype), is_option);
+				GUINT_TO_POINTER((guint) acked_option->type),
+				is_option);
 		if (list) {
 			/*
 			 * once we've applied the option, delete it from
@@ -1266,10 +1276,11 @@ static guint8 pppcp_process_configure_ack(struct pp=
pcp_data *data,
 				g_list_delete_link(data->config_options, list);
 		} else
 			g_printerr("oops -- found acked option %d we didn't request\n", acked_o=
ption->type);
-		g_free(acked_option);
 =

 		/* skip ahead to the next option */
-		i +=3D olen;
+		i +=3D acked_option->length;
+
+		g_free(acked_option);
 	}
 	return RCA;
 }
@@ -1300,14 +1311,13 @@ static guint8 pppcp_process_configure_nak(struct pp=
pcp_data *data,
 	 * modify a value there, or add a new option.
 	 */
 	while (i < len) {
-		guint8 otype =3D packet->data[i];
-		guint8 olen =3D packet->data[i+1];
-		naked_option =3D g_try_malloc0(olen);
+		naked_option =3D extract_ppp_option(&packet->data[i]);
 		if (naked_option =3D=3D NULL)
 			break;
-		naked_option->type =3D otype;
-		naked_option->length =3D olen;
-		memcpy(naked_option->data, &packet->data[i + 2], olen - 2);
+
+		/* skip ahead to the next option */
+		i +=3D naked_option->length;
+
 		if (action->option_scan)
 			rval =3D action->option_scan(naked_option, data);
 		if (rval =3D=3D OPTION_ACCEPT) {
@@ -1316,7 +1326,8 @@ static guint8 pppcp_process_configure_nak(struct pppc=
p_data *data,
 			 * match.
 			 */
 			list =3D g_list_find_custom(data->config_options,
-				GUINT_TO_POINTER((guint) otype), is_option);
+				GUINT_TO_POINTER((guint) naked_option->type),
+				is_option);
 			if (list) {
 				/* modify current option value to match */
 				config_option =3D list->data;
@@ -1326,10 +1337,11 @@ static guint8 pppcp_process_configure_nak(struct pp=
pcp_data *data,
 				 * we need to reallocate
 				 */
 				if ((config_option->length =3D=3D
-					naked_option->length) && (olen - 2)) {
+					naked_option->length) &&
+							(naked_option - 2)) {
 						memcpy(config_option->data,
-							naked_option->data,
-							olen - 2);
+						   naked_option->data,
+						   naked_option->length - 2);
 				} else {
 					/* XXX implement this */
 					g_printerr("uh oh, option value doesn't match\n");
@@ -1344,9 +1356,6 @@ static guint8 pppcp_process_configure_nak(struct pppc=
p_data *data,
 			g_printerr("oops, option wasn't acceptable\n");
 			g_free(naked_option);
 		}
-
-		/* skip ahead to the next option */
-		i +=3D olen;
 	}
 	return RCN;
 }
-- =

1.6.6.1


--===============4991568662542391202==--

