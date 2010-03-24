Content-Type: multipart/mixed; boundary="===============2923140980491543717=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/3] fix memory leaks after ppp_transmit
Date: Wed, 24 Mar 2010 10:13:24 -0700
Message-ID: <1269450805-3661-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269450805-3661-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2923140980491543717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Free packets in ppp_cp after calling ppp_transmit()
---
 gatchat/ppp_cp.c |   36 +++++++++++++++++++++++++++---------
 1 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 0f04fa1..b02f4ba 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -48,7 +48,7 @@ static const char *pppcp_state_strings[] =3D
 #endif
 =

 #define pppcp_to_ppp_packet(p) \
-	(p-PPP_HEADROOM)
+	(((guint8 *) p) - PPP_HEADROOM)
 =

 struct pppcp_event {
 	enum pppcp_event_type type;
@@ -62,6 +62,11 @@ struct pppcp_event {
 #define MAX_FAILURE		5
 #define CP_HEADER_SZ		4
 =

+static void pppcp_packet_free(struct pppcp_packet *packet)
+{
+	g_free(pppcp_to_ppp_packet(packet));
+}
+
 static struct pppcp_packet *pppcp_packet_new(struct pppcp_data *data,
 						guint type, guint bufferlen)
 {
@@ -291,9 +296,11 @@ static void pppcp_send_configure_request(struct pppcp_=
data *data)
 			new_identity(data, data->config_identifier);
 	packet->identifier =3D data->config_identifier;
 =

-	ppp_transmit(data->ppp, pppcp_to_ppp_packet((guint8 *) packet),
+	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
 =

+	pppcp_packet_free(packet);
+
 	/* XXX don't retransmit right now */
 #if 0
 	data->restart_counter--;
@@ -327,8 +334,9 @@ static void pppcp_send_configure_ack(struct pppcp_data =
*data,
 	/* match identifier of the request */
 	packet->identifier =3D pppcp_header->identifier;
 =

-	ppp_transmit(data->ppp, pppcp_to_ppp_packet((guint8 *) packet),
+	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
+	pppcp_packet_free(packet);
 }
 =

 /*
@@ -357,9 +365,10 @@ static void pppcp_send_configure_nak(struct pppcp_data=
 *data,
 				&odata);
 =

 		packet->identifier =3D pppcp_header->identifier;
-		ppp_transmit(data->ppp, pppcp_to_ppp_packet((guint8 *) packet),
+		ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
 =

+		pppcp_packet_free(packet);
 	}
 	/* if we have any unacceptable options, send a config-nak */
 	if (g_list_length(data->unacceptable_options)) {
@@ -377,8 +386,10 @@ static void pppcp_send_configure_nak(struct pppcp_data=
 *data,
 				&odata);
 =

 		packet->identifier =3D pppcp_header->identifier;
-		ppp_transmit(data->ppp, pppcp_to_ppp_packet((guint8 *) packet),
+		ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 				ntohs(packet->length));
+
+		pppcp_packet_free(packet);
 	}
 }
 =

@@ -405,8 +416,10 @@ static void pppcp_send_terminate_request(struct pppcp_=
data *data)
 		data->terminate_identifier =3D
 			new_identity(data, data->terminate_identifier);
 	packet->identifier =3D data->terminate_identifier;
-	ppp_transmit(data->ppp, pppcp_to_ppp_packet((guint8 *) packet),
+	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
+
+	pppcp_packet_free(packet);
 	data->restart_counter--;
 	pppcp_start_timer(data);
 }
@@ -425,8 +438,10 @@ static void pppcp_send_terminate_ack(struct pppcp_data=
 *data,
 	/* match identifier of the request */
 	packet->identifier =3D pppcp_header->identifier;
 =

-	ppp_transmit(data->ppp, pppcp_to_ppp_packet((guint8 *) packet),
+	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(pppcp_header->length));
+
+	pppcp_packet_free(packet);
 }
 =

 /*
@@ -454,8 +469,10 @@ static void pppcp_send_code_reject(struct pppcp_data *=
data,
 	memcpy(packet->data, rejected_packet,
 			ntohs(packet->length - CP_HEADER_SZ));
 =

-	ppp_transmit(data->ppp, pppcp_to_ppp_packet((guint8 *) packet),
+	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
+
+	pppcp_packet_free(packet);
 }
 =

 /*
@@ -478,9 +495,10 @@ static void pppcp_send_echo_reply(struct pppcp_data *d=
ata,
 	packet->identifier =3D header->identifier;
 =

 	/* magic number? */
-	ppp_transmit(data->ppp, pppcp_to_ppp_packet((guint8 *) packet),
+	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
 =

+	pppcp_packet_free(packet);
 }
 =

 static void pppcp_transition_state(enum pppcp_state new_state,
-- =

1.6.6.1


--===============2923140980491543717==--

