Content-Type: multipart/mixed; boundary="===============8035485041709946418=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 5/5] ppp: handle Config-Reject
Date: Fri, 26 Mar 2010 18:34:30 -0700
Message-ID: <1269653670-31352-6-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269653670-31352-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8035485041709946418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

if our peer sends us a Config-Reject packet, we must delete that
config item and not request that it be negotiated when we send our
next Config-Request.
---
 gatchat/ppp_cp.c |   49 ++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index d7d70b7..ac1a37d 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -1363,22 +1363,49 @@ static guint8 pppcp_process_configure_nak(struct pp=
pcp_data *data,
 static guint8 pppcp_process_configure_reject(struct pppcp_data *data,
 					struct pppcp_packet *packet)
 {
+	guint len;
+	GList *list;
+	struct ppp_option *rejected_option;
+	guint i =3D 0;
+
+	len =3D ntohs(packet->length) - CP_HEADER_SZ;
+
 	/*
 	 * make sure identifier matches that of last sent configure
 	 * request
 	 */
-	if (packet->identifier =3D=3D data->config_identifier) {
-		/*
-		 * check to see which options were rejected
-		 * Rejected options must be a subset of requested
-		 * options.
-		 *
-		 * when a new configure-request is sent, we may
-		 * not request any of these options be negotiated
-		 */
-		return RCN;
+	if (packet->identifier !=3D data->config_identifier)
+		return 0;
+
+	/*
+	 * check to see which options were rejected
+	 * Rejected options must be a subset of requested
+	 * options.
+	 *
+	 * when a new configure-request is sent, we may
+	 * not request any of these options be negotiated
+	 */
+	while (i < len) {
+		rejected_option =3D extract_ppp_option(&packet->data[i]);
+		if (rejected_option =3D=3D NULL)
+			break;
+
+		/* skip ahead to the next option */
+		i +=3D rejected_option->length;
+
+		/* find this option in our config options list */
+		list =3D g_list_find_custom(data->config_options,
+			GUINT_TO_POINTER((guint) rejected_option->type),
+			is_option);
+		if (list) {
+			/* delete this config option */
+			g_free(list->data);
+			data->config_options =3D
+				g_list_delete_link(data->config_options, list);
+		}
+		g_free(rejected_option);
 	}
-	return 0;
+	return RCN;
 }
 =

 static guint8 pppcp_process_terminate_request(struct pppcp_data *data,
-- =

1.6.6.1


--===============8035485041709946418==--

