Content-Type: multipart/mixed; boundary="===============0003542616740935961=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/3] fix memory leaks in option handling
Date: Wed, 24 Mar 2010 10:13:23 -0700
Message-ID: <1269450805-3661-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269450805-3661-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0003542616740935961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

free the data as well as the link when deleting options lists.
---
 gatchat/ppp_cp.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index e8d6e30..0f04fa1 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -201,6 +201,16 @@ static void pppcp_clear_options(struct pppcp_data *dat=
a)
 	data->rejected_options =3D NULL;
 }
 =

+static void pppcp_free_options(struct pppcp_data *data)
+{
+	/* remove all config options */
+	pppcp_clear_options(data);
+
+	/* remove default option list */
+	g_list_foreach(data->config_options, pppcp_free_option, NULL);
+	g_list_free(data->config_options);
+}
+
 /*
  * set the restart counter to either max-terminate
  * or max-configure.  The counter is decremented for
@@ -1103,6 +1113,7 @@ static void remove_config_option(gpointer elem, gpoin=
ter user_data)
 	if (!list)
 		return;
 =

+	g_free(list->data);
 	data->config_options =3D g_list_delete_link(data->config_options, list);
 }
 =

@@ -1226,6 +1237,8 @@ static guint8 pppcp_process_configure_ack(struct pppc=
p_data *data,
 			if (action->option_process)
 				action->option_process(acked_option,
 							data->priv);
+
+			g_free(list->data);
 			data->config_options =3D
 				g_list_delete_link(data->config_options, list);
 		} else
@@ -1440,7 +1453,7 @@ void pppcp_free(struct pppcp_data *data)
 	g_queue_free(data->event_queue);
 =

 	/* remove all config options */
-	pppcp_clear_options(data);
+	pppcp_free_options(data);
 =

 	/* free self */
 	g_free(data);
-- =

1.6.6.1


--===============0003542616740935961==--

