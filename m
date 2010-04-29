Content-Type: multipart/mixed; boundary="===============4687128106563350010=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: ppp: transition to dead when read io destroyed
Date: Thu, 29 Apr 2010 11:03:09 -0700
Message-ID: <20100429110309.31165a8f@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4687128106563350010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

remove call to signal_close for lcp object, it is redundent.  If
our io is destroyed we are dead, so transition the ppp phase to
DEAD so our disconnect callback can be called.
---
 gatchat/gatppp.c |    2 +-
 gatchat/ppp_cp.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index dfdaf40..3450ce3 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -180,7 +180,6 @@ void ppp_enter_phase(GAtPPP *ppp, enum ppp_phase phase)
 	case PPP_PHASE_TERMINATION:
 		pppcp_signal_down(ppp->ipcp);
 		pppcp_signal_close(ppp->ipcp);
-		pppcp_signal_close(ppp->lcp);
 		break;
 	case PPP_PHASE_DEAD:
 		ppp_dead(ppp);
@@ -269,6 +268,7 @@ static void io_disconnect(gpointer user_data)
 	GAtPPP *ppp =3D user_data;
 =

 	pppcp_signal_down(ppp->lcp);
+	ppp_enter_phase(ppp, PPP_PHASE_DEAD);
 }
 =

 /* Administrative Open */
diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 9db96d6..00acb73 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -523,6 +523,7 @@ static void pppcp_send_terminate_ack(struct pppcp_data =
*data,
 {
 	struct pppcp_packet *packet;
 	struct pppcp_packet *pppcp_header =3D (struct pppcp_packet *) request;
+	struct pppcp_timer_data *timer_data =3D &data->terminate_timer_data;
 =

 	pppcp_trace(data);
 =

@@ -535,6 +536,7 @@ static void pppcp_send_terminate_ack(struct pppcp_data =
*data,
 			ntohs(pppcp_header->length));
 =

 	pppcp_packet_free(packet);
+	pppcp_start_timer(timer_data);
 }
 =

 /*
-- =

1.6.6.1


--===============4687128106563350010==--

