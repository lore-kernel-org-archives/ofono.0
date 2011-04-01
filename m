Content-Type: multipart/mixed; boundary="===============7370325014945825732=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 12/26] gatppp: add g_at_ppp_suspend() prototype
Date: Fri, 01 Apr 2011 10:56:14 +0200
Message-ID: <1301648188-7208-13-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7370325014945825732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 7835d1f..e4e9f5f 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -64,6 +64,7 @@ void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func, g=
pointer user_data);
 void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspendFunc func,
 					gpointer user_data);
 void g_at_ppp_shutdown(GAtPPP *ppp);
+void g_at_ppp_suspend(GAtPPP *ppp);
 void g_at_ppp_ref(GAtPPP *ppp);
 void g_at_ppp_unref(GAtPPP *ppp);
 =

-- =

1.7.1


--===============7370325014945825732==--

