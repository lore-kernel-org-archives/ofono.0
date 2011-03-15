Content-Type: multipart/mixed; boundary="===============4752624215694559092=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 4/6] gatppp: add prototype to set ppp suspend function.
Date: Tue, 15 Mar 2011 10:19:01 +0100
Message-ID: <1300180743-27624-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4752624215694559092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index fb5de4c..7835d1f 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -61,6 +61,8 @@ void g_at_ppp_set_connect_function(GAtPPP *ppp, GAtPPPCon=
nectFunc callback,
 void g_at_ppp_set_disconnect_function(GAtPPP *ppp, GAtPPPDisconnectFunc fu=
nc,
 					gpointer user_data);
 void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func, gpointer user_data=
);
+void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspendFunc func,
+					gpointer user_data);
 void g_at_ppp_shutdown(GAtPPP *ppp);
 void g_at_ppp_ref(GAtPPP *ppp);
 void g_at_ppp_unref(GAtPPP *ppp);
-- =

1.7.1


--===============4752624215694559092==--

