Content-Type: multipart/mixed; boundary="===============1318024344794432696=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: implement Max-Failure counter
Date: Fri, 02 Apr 2010 22:27:00 -0700
Message-ID: <1270272420-4468-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1318024344794432696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

put a cap on the number of Configure-Nak packets we send.
---
 gatchat/ppp_cp.c |   22 ++++++++++++++++++++++
 gatchat/ppp_cp.h |    1 +
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index cf2f5fa..5e854da 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -238,6 +238,15 @@ static void copy_option(gpointer data, gpointer user_d=
ata)
 	*location +=3D option->length;
 }
 =

+static void reject_option(gpointer data, gpointer user_data)
+{
+	struct ppp_option *option =3D data;
+	struct pppcp_data *pppcp =3D user_data;
+
+	pppcp->rejected_options =3D
+		g_list_append(pppcp->rejected_options, option);
+}
+
 static void print_option(gpointer data, gpointer user_data)
 {
 	struct ppp_option *option =3D data;
@@ -315,6 +324,8 @@ static void pppcp_send_configure_ack(struct pppcp_data =
*data,
 =

 	pppcp_trace(data);
 =

+	data->failure_counter =3D 0;
+
 	g_list_foreach(data->acceptable_options, print_option, data);
 =

 	/* subtract for header. */
@@ -347,6 +358,16 @@ static void pppcp_send_configure_nak(struct pppcp_data=
 *data,
 	guint8 olength;
 	guint8 *odata;
 =

+	/*
+	 * if we have exceeded our Max-Failure counter, we need
+	 * to convert all packets to Configure-Reject
+	 */
+	if (data->failure_counter >=3D data->max_failure) {
+		g_list_foreach(data->unacceptable_options, reject_option, data);
+		g_list_free(data->unacceptable_options);
+		data->unacceptable_options =3D NULL;
+	}
+
 	/* if we have any rejected options, send a config-reject */
 	if (g_list_length(data->rejected_options)) {
 		pppcp_trace(data);
@@ -395,6 +416,7 @@ static void pppcp_send_configure_nak(struct pppcp_data =
*data,
 				ntohs(packet->length));
 =

 		pppcp_packet_free(packet);
+		data->failure_counter++;
 	}
 }
 =

diff --git a/gatchat/ppp_cp.h b/gatchat/ppp_cp.h
index 5b5d589..ee7ac8d 100644
--- a/gatchat/ppp_cp.h
+++ b/gatchat/ppp_cp.h
@@ -111,6 +111,7 @@ struct pppcp_data {
 	struct pppcp_timer_data config_timer_data;
 	struct pppcp_timer_data terminate_timer_data;
 	guint max_failure;
+	guint failure_counter;
 	guint32 magic_number;
 	GList *config_options;
 	GList *acceptable_options;
-- =

1.6.6.1


--===============1318024344794432696==--

