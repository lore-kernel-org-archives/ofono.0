Content-Type: multipart/mixed; boundary="===============7321640025374246893=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 15/18] gatppp: add prototype to suspend ppp server externally
Date: Fri, 25 Mar 2011 16:25:46 +0100
Message-ID: <1301066749-12052-16-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7321640025374246893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 71e0afe..61ffb4a 100644
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


--===============7321640025374246893==--

