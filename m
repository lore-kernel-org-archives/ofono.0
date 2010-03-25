Content-Type: multipart/mixed; boundary="===============4414000017852708721=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 2/4] add tracing for PPP terminate path
Date: Wed, 24 Mar 2010 21:41:53 -0700
Message-ID: <1269492115-15412-3-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269492115-15412-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4414000017852708721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Insert some calls to pppcp_trace() for future debugging needs.
---
 gatchat/ppp_cp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 4cc6c13..df14a33 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -399,6 +399,8 @@ static void pppcp_send_terminate_request(struct pppcp_d=
ata *data)
 	struct pppcp_packet *packet;
 	struct pppcp_timer_data *timer_data =3D &data->terminate_timer_data;
 =

+	pppcp_trace(data);
+
 	/*
 	 * the data field can be used by the sender (us).
 	 * leave this empty for now.
@@ -430,6 +432,8 @@ static void pppcp_send_terminate_ack(struct pppcp_data =
*data,
 	struct pppcp_packet *packet;
 	struct pppcp_packet *pppcp_header =3D (struct pppcp_packet *) request;
 =

+	pppcp_trace(data);
+
 	packet =3D pppcp_packet_new(data, TERMINATE_ACK, 0);
 =

 	/* match identifier of the request */
@@ -621,6 +625,8 @@ static void pppcp_open_event(struct pppcp_data *data, g=
uint8 *packet, guint len)
 =

 static void pppcp_close_event(struct pppcp_data *data, guint8* packet, gui=
nt len)
 {
+	pppcp_trace(data);
+
 	switch (data->state) {
 	case INITIAL:
 		pppcp_transition_state(INITIAL, data);
@@ -1366,6 +1372,8 @@ static guint8 pppcp_process_configure_reject(struct p=
ppcp_data *data,
 static guint8 pppcp_process_terminate_request(struct pppcp_data *data,
 					struct pppcp_packet *packet)
 {
+	pppcp_trace(data);
+
 	return RTR;
 }
 =

@@ -1378,6 +1386,8 @@ static guint8 pppcp_process_terminate_ack(struct pppc=
p_data *data,
 	 * even if the identifiers don't match, we still handle
 	 * a terminate ack, as it is allowed to be unelicited
 	 */
+	pppcp_trace(data);
+
 	return RTA;
 }
 =

-- =

1.6.6.1


--===============4414000017852708721==--

