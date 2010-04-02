Content-Type: multipart/mixed; boundary="===============0980605151149827157=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: fix missing breaks in switchs
Date: Fri, 02 Apr 2010 13:16:35 -0700
Message-ID: <1270239395-9618-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0980605151149827157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp_cp.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index d5f7c92..cf2f5fa 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -591,7 +591,7 @@ static void pppcp_down_event(struct pppcp_data *data, g=
uint8 *packet, guint len)
 	case OPENED:
 		pppcp_transition_state(STARTING, data);
 		pppcp_this_layer_down(data);
-		/* fall through */
+		break;
 	case INITIAL:
 	case STARTING:
 		/* illegal */
@@ -840,7 +840,7 @@ static void pppcp_rca_event(struct pppcp_data *data, gu=
int8 *packet, guint len)
 		/* scr/6x */
 		pppcp_send_configure_request(data);
 		pppcp_transition_state(REQSENT, data);
-		/* fall through */
+		break;
 	case ACKSENT:
 		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_this_layer_up(data);
@@ -870,7 +870,7 @@ static void pppcp_rcn_event(struct pppcp_data *data, gu=
int8 *packet, guint len)
 	case CLOSING:
 	case STOPPING:
 		pppcp_transition_state(data->state, data);
-		/* fall through */
+		break;
 	case REQSENT:
 		pppcp_initialize_restart_count(&data->config_timer_data);
 		pppcp_send_configure_request(data);
@@ -905,10 +905,9 @@ static void pppcp_rtr_event(struct pppcp_data *data, g=
uint8 *packet, guint len)
 	switch (data->state) {
 	case CLOSED:
 	case STOPPED:
-		pppcp_send_terminate_ack(data, packet);
-		/* fall through */
 	case CLOSING:
 	case STOPPING:
+		pppcp_send_terminate_ack(data, packet);
 		break;
 	case REQSENT:
 	case ACKRCVD:
-- =

1.6.6.1


--===============0980605151149827157==--

