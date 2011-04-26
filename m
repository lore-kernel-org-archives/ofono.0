Content-Type: multipart/mixed; boundary="===============5028424511921316880=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH 1/2] Fix ofonod crash issue
Date: Tue, 26 Apr 2011 17:07:42 +0800
Message-ID: <1303808863-831-1-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5028424511921316880==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

In case of offline modem when GPRS data connection is connected, if gprs
atom is removed before PPP termination process is complete, the terminate_t=
imer
will not be stop. It will cause ofonod crash when the timer time out.
---
 gatchat/ppp_cp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index f0731cc..6e4a9c5 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -970,6 +970,8 @@ void pppcp_process_packet(gpointer priv, const guint8 *=
new_packet)
 =

 void pppcp_free(struct pppcp_data *pppcp)
 {
+	pppcp_stop_timer(&pppcp->config_timer_data);
+	pppcp_stop_timer(&pppcp->terminate_timer_data);
 	g_free(pppcp->peer_options);
 	g_free(pppcp);
 }
-- =

1.7.2.2


--===============5028424511921316880==--

