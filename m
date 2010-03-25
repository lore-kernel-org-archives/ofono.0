Content-Type: multipart/mixed; boundary="===============0845179031575127665=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/2] use separate timers for PPP config and terminate
Date: Wed, 24 Mar 2010 20:26:28 -0700
Message-ID: <1269487588-14046-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269487588-14046-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0845179031575127665==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prevent conflicts between config timer information and terminate timer
information by providing a new data structure which keeps timer information
for config and terminate requests separate.
---
 gatchat/ppp_cp.c |  101 ++++++++++++++++++++++++++++----------------------=
---
 gatchat/ppp_cp.h |   15 +++++---
 2 files changed, 63 insertions(+), 53 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index de72066..4cc6c13 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -91,40 +91,41 @@ static struct pppcp_packet *pppcp_packet_new(struct ppp=
cp_data *data,
 =

 static gboolean pppcp_timeout(gpointer user_data)
 {
-	struct pppcp_data *data =3D user_data;
+	struct pppcp_timer_data *timer_data =3D user_data;
 =

-	pppcp_trace(data);
+	pppcp_trace(timer_data->data);
 =

-	data->restart_timer =3D 0;
+	timer_data->restart_timer =3D 0;
 =

-	if (data->restart_counter)
-		pppcp_generate_event(data, TO_PLUS, NULL, 0);
+	if (timer_data->restart_counter)
+		pppcp_generate_event(timer_data->data, TO_PLUS, NULL, 0);
 	else
-		pppcp_generate_event(data, TO_MINUS, NULL, 0);
+		pppcp_generate_event(timer_data->data, TO_MINUS, NULL, 0);
 =

 	return FALSE;
 }
 =

-static void pppcp_start_timer(struct pppcp_data *data)
+static void pppcp_start_timer(struct pppcp_timer_data *timer_data)
 {
-	data->restart_timer =3D g_timeout_add_seconds(data->restart_interval,
-				pppcp_timeout, data);
+	if (timer_data->restart_timer)
+		return;
+
+	timer_data->restart_timer =3D
+		g_timeout_add_seconds(timer_data->restart_interval,
+				pppcp_timeout, timer_data);
 }
 =

-static void pppcp_stop_timer(struct pppcp_data *data)
+static void pppcp_stop_timer(struct pppcp_timer_data *timer_data)
 {
-	if (data->restart_timer) {
-		g_source_remove(data->restart_timer);
-		data->restart_timer =3D 0;
+	if (timer_data->restart_timer) {
+		g_source_remove(timer_data->restart_timer);
+		timer_data->restart_timer =3D 0;
 	}
 }
 =

-static gboolean pppcp_timer_is_running(struct pppcp_data *data)
+static gboolean is_first_request(struct pppcp_timer_data *timer_data)
 {
-	/* determine if the restart timer is running */
-	if (data->restart_timer)
-		return TRUE;
-	return FALSE;
+	return (timer_data->restart_counter =3D=3D timer_data->max_counter);
 }
 =

 static struct pppcp_event *pppcp_event_new(enum pppcp_event_type type,
@@ -215,19 +216,21 @@ static void pppcp_free_options(struct pppcp_data *dat=
a)
  * or max-configure.  The counter is decremented for
  * each transmission, including the first.
  */
-static void pppcp_initialize_restart_count(struct pppcp_data *data, guint =
value)
+static void pppcp_initialize_restart_count(struct pppcp_timer_data *timer_=
data)
 {
+	struct pppcp_data *data =3D timer_data->data;
+
 	pppcp_trace(data);
 	pppcp_clear_options(data);
-	data->restart_counter =3D value;
+	timer_data->restart_counter =3D timer_data->max_counter;
 }
 =

 /*
  * set restart counter to zero
  */
-static void pppcp_zero_restart_count(struct pppcp_data *data)
+static void pppcp_zero_restart_count(struct pppcp_timer_data *timer_data)
 {
-	data->restart_counter =3D 0;
+	timer_data->restart_counter =3D 0;
 }
 =

 /*
@@ -269,6 +272,7 @@ static void pppcp_send_configure_request(struct pppcp_d=
ata *data)
 	struct pppcp_packet *packet;
 	guint8 olength =3D 0;
 	guint8 *odata;
+	struct pppcp_timer_data *timer_data =3D &data->config_timer_data;
 =

 	pppcp_trace(data);
 =

@@ -285,7 +289,7 @@ static void pppcp_send_configure_request(struct pppcp_d=
ata *data)
 	 * if this is the first request, we need a new identifier.
 	 * if this is a retransmission, leave the identifier alone.
 	 */
-	if (data->restart_counter =3D=3D data->max_configure)
+	if (is_first_request(timer_data))
 		data->config_identifier =3D
 			new_identity(data, data->config_identifier);
 	packet->identifier =3D data->config_identifier;
@@ -295,11 +299,9 @@ static void pppcp_send_configure_request(struct pppcp_=
data *data)
 =

 	pppcp_packet_free(packet);
 =

-	/* XXX don't retransmit right now */
-#if 0
-	data->restart_counter--;
-	pppcp_start_timer(data);
-#endif
+	/* start timer for retransmission */
+	timer_data->restart_counter--;
+	pppcp_start_timer(timer_data);
 }
 =

 /*
@@ -395,6 +397,7 @@ static void pppcp_send_configure_nak(struct pppcp_data =
*data,
 static void pppcp_send_terminate_request(struct pppcp_data *data)
 {
 	struct pppcp_packet *packet;
+	struct pppcp_timer_data *timer_data =3D &data->terminate_timer_data;
 =

 	/*
 	 * the data field can be used by the sender (us).
@@ -406,7 +409,7 @@ static void pppcp_send_terminate_request(struct pppcp_d=
ata *data)
 	 * Is this a retransmission?  If so, do not change
 	 * the identifier.  If not, we need a fresh identity.
 	 */
-	if (data->restart_counter =3D=3D data->max_terminate)
+	if (is_first_request(timer_data))
 		data->terminate_identifier =3D
 			new_identity(data, data->terminate_identifier);
 	packet->identifier =3D data->terminate_identifier;
@@ -414,8 +417,8 @@ static void pppcp_send_terminate_request(struct pppcp_d=
ata *data)
 			ntohs(packet->length));
 =

 	pppcp_packet_free(packet);
-	data->restart_counter--;
-	pppcp_start_timer(data);
+	timer_data->restart_counter--;
+	pppcp_start_timer(timer_data);
 }
 =

 /*
@@ -509,9 +512,8 @@ static void pppcp_transition_state(enum pppcp_state new=
_state,
 	case CLOSED:
 	case STOPPED:
 	case OPENED:
-		/* if timer is running, stop it */
-		if (pppcp_timer_is_running(data))
-			pppcp_stop_timer(data);
+		pppcp_stop_timer(&data->config_timer_data);
+		pppcp_stop_timer(&data->terminate_timer_data);
 		break;
 	case CLOSING:
 	case STOPPING:
@@ -533,7 +535,7 @@ static void pppcp_up_event(struct pppcp_data *data, gui=
nt8 *packet, guint len)
 		break;
 	case STARTING:
 		/* irc, scr/6 */
-		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_send_configure_request(data);
 		pppcp_transition_state(REQSENT, data);
 		break;
@@ -592,7 +594,7 @@ static void pppcp_open_event(struct pppcp_data *data, g=
uint8 *packet, guint len)
 		pppcp_transition_state(STARTING, data);
 		break;
 	case CLOSED:
-		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_send_configure_request(data);
 		pppcp_transition_state(REQSENT, data);
 		break;
@@ -640,7 +642,7 @@ static void pppcp_close_event(struct pppcp_data *data, =
guint8* packet, guint len
 	case REQSENT:
 	case ACKRCVD:
 	case ACKSENT:
-		pppcp_initialize_restart_count(data, data->max_terminate);
+		pppcp_initialize_restart_count(&data->terminate_timer_data);
 		pppcp_send_terminate_request(data);
 		pppcp_transition_state(CLOSING, data);
 		break;
@@ -716,7 +718,7 @@ static void pppcp_rcr_plus_event(struct pppcp_data *dat=
a,
 		pppcp_transition_state(CLOSED, data);
 		break;
 	case STOPPED:
-		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_send_configure_request(data);
 		pppcp_send_configure_ack(data, packet);
 		pppcp_transition_state(ACKSENT, data);
@@ -761,7 +763,7 @@ static void pppcp_rcr_minus_event(struct pppcp_data *da=
ta,
 		pppcp_transition_state(CLOSED, data);
 		break;
 	case STOPPED:
-		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_send_configure_request(data);
 		pppcp_send_configure_nak(data, packet);
 		pppcp_transition_state(REQSENT, data);
@@ -804,7 +806,7 @@ static void pppcp_rca_event(struct pppcp_data *data, gu=
int8 *packet, guint len)
 		pppcp_transition_state(data->state, data);
 		break;
 	case REQSENT:
-		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_transition_state(ACKRCVD, data);
 		break;
 	case ACKRCVD:
@@ -812,7 +814,7 @@ static void pppcp_rca_event(struct pppcp_data *data, gu=
int8 *packet, guint len)
 		pppcp_send_configure_request(data);
 		pppcp_transition_state(REQSENT, data);
 	case ACKSENT:
-		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_this_layer_up(data);
 		pppcp_transition_state(OPENED, data);
 		break;
@@ -839,7 +841,7 @@ static void pppcp_rcn_event(struct pppcp_data *data, gu=
int8 *packet, guint len)
 	case STOPPING:
 		pppcp_transition_state(data->state, data);
 	case REQSENT:
-		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_send_configure_request(data);
 		pppcp_transition_state(REQSENT, data);
 		break;
@@ -849,7 +851,7 @@ static void pppcp_rcn_event(struct pppcp_data *data, gu=
int8 *packet, guint len)
 		pppcp_transition_state(REQSENT, data);
 		break;
 	case ACKSENT:
-		pppcp_initialize_restart_count(data, data->max_configure);
+		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_send_configure_request(data);
 		pppcp_transition_state(ACKSENT, data);
 		break;
@@ -883,7 +885,7 @@ static void pppcp_rtr_event(struct pppcp_data *data, gu=
int8 *packet, guint len)
 		break;
 	case OPENED:
 		pppcp_this_layer_down(data);
-		pppcp_zero_restart_count(data);
+		pppcp_zero_restart_count(&data->terminate_timer_data);
 		pppcp_send_terminate_ack(data, packet);
 		pppcp_transition_state(STOPPING, data);
 		break;
@@ -1002,7 +1004,7 @@ static void pppcp_rxj_minus_event(struct pppcp_data *=
data,
 		break;
 	case OPENED:
 		pppcp_this_layer_down(data);
-		pppcp_initialize_restart_count(data, data->max_terminate);
+		pppcp_initialize_restart_count(&data->terminate_timer_data);
 		pppcp_send_terminate_request(data);
 		pppcp_transition_state(STOPPING, data);
 		break;
@@ -1481,9 +1483,12 @@ struct pppcp_data *pppcp_new(GAtPPP *ppp, guint16 pr=
oto,
 		return NULL;
 =

 	data->state =3D INITIAL;
-	data->restart_interval =3D INITIAL_RESTART_TIMEOUT;
-	data->max_terminate =3D MAX_TERMINATE;
-	data->max_configure =3D MAX_CONFIGURE;
+	data->config_timer_data.restart_interval =3D INITIAL_RESTART_TIMEOUT;
+	data->terminate_timer_data.restart_interval =3D INITIAL_RESTART_TIMEOUT;
+	data->config_timer_data.max_counter =3D MAX_CONFIGURE;
+	data->terminate_timer_data.max_counter =3D MAX_TERMINATE;
+	data->config_timer_data.data =3D data;
+	data->terminate_timer_data.data =3D data;
 	data->max_failure =3D MAX_FAILURE;
 	data->event_queue =3D g_queue_new();
 	data->identifier =3D 0;
diff --git a/gatchat/ppp_cp.h b/gatchat/ppp_cp.h
index 875d02f..095a8b5 100644
--- a/gatchat/ppp_cp.h
+++ b/gatchat/ppp_cp.h
@@ -98,13 +98,18 @@ struct pppcp_packet {
 	guint8 data[0];
 } __attribute__((packed));
 =

-struct pppcp_data {
-	enum pppcp_state state;
-	guint restart_timer;
+struct pppcp_timer_data {
+	struct pppcp_data *data;
 	guint restart_counter;
 	guint restart_interval;
-	guint max_terminate;
-	guint max_configure;
+	guint max_counter;
+	guint restart_timer;
+};
+
+struct pppcp_data {
+	enum pppcp_state state;
+	struct pppcp_timer_data config_timer_data;
+	struct pppcp_timer_data terminate_timer_data;
 	guint max_failure;
 	guint32 magic_number;
 	GQueue *event_queue;
-- =

1.6.6.1


--===============0845179031575127665==--

