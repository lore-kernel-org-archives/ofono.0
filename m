Content-Type: multipart/mixed; boundary="===============3606837816191473273=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] ppp: Fix leak in pppcp_send_protocol_reject
Date: Mon, 21 Jun 2010 17:25:39 +0800
Message-ID: <1277112339-15009-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3606837816191473273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Free the reject pppcp packet after ppp_transmit.
---
 gatchat/ppp_cp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index bade6bb..b0a18aa 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -938,6 +938,8 @@ void pppcp_send_protocol_reject(struct pppcp_data *data,
 =

 	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
+
+	pppcp_packet_free(packet);
 }
 =

 /*
-- =

1.6.3.3


--===============3606837816191473273==--

