Content-Type: multipart/mixed; boundary="===============0167541126825381207=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 18/26] ppp: add ppp_net_resume_interface() prototype
Date: Fri, 01 Apr 2011 10:56:20 +0200
Message-ID: <1301648188-7208-19-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0167541126825381207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/ppp.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 22809d8..ae96e42 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -108,6 +108,7 @@ void ppp_net_process_packet(struct ppp_net *net, const =
guint8 *packet);
 void ppp_net_free(struct ppp_net *net);
 gboolean ppp_net_set_mtu(struct ppp_net *net, guint16 mtu);
 void ppp_net_suspend_interface(struct ppp_net *net);
+void ppp_net_resume_interface(struct ppp_net *net);
 =

 /* PPP functions related to main GAtPPP object */
 void ppp_debug(GAtPPP *ppp, const char *str);
-- =

1.7.1


--===============0167541126825381207==--

