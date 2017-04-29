Content-Type: multipart/mixed; boundary="===============6817738605654706809=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi lte v5 1/4] qmi: watch packet status for spontaneous
 disconnection only
Date: Sat, 29 Apr 2017 14:46:40 +0200
Message-ID: <20170429124643.21080-2-jonas@southpole.se>
In-Reply-To: <20170429124643.21080-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6817738605654706809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are three principal ways for a context to become disconnected:

i)  deactivate_primary() is called
ii)  the network registration is lost and the context is cleaned up
via _detach_shutdown() (via release_all_contexts())
iii) the network decides to disconnect the context

We need to watch the packet status in order to detect case iii).  For
case i) and ii), stop_net will be called, the pkt_handle will be
cleared, and subsequent packet status notifications be ignored.

This patch makes it so that the packet status "disconnected" event
is only propagated when the pkt_handle has not been cleared, indicating
an unrequested disconnection.

This should fix a race reported by Christophe Ronco whereby the packet
status disconnect notification is called between activate_primary
(start_net) and it's callback (start_net_cb).
---
 drivers/qmimodem/gprs-context.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/qmimodem/gprs-context.c b/drivers/qmimodem/gprs-contex=
t.c
index af1ce16..80cba76 100644
--- a/drivers/qmimodem/gprs-context.c
+++ b/drivers/qmimodem/gprs-context.c
@@ -65,8 +65,12 @@ static void pkt_status_notify(struct qmi_result *result,=
 void *user_data)
 =

 	switch (status->status) {
 	case QMI_WDS_CONN_STATUS_DISCONNECTED:
-		ofono_gprs_context_deactivated(gc, data->active_context);
-		data->active_context =3D 0;
+		if (data->pkt_handle) {
+			/* The context has been disconnected by the network */ =

+			ofono_gprs_context_deactivated(gc, data->active_context);
+			data->pkt_handle =3D 0;
+			data->active_context =3D 0;
+		}
 		break;
 	}
 }
-- =

2.9.3


--===============6817738605654706809==--

