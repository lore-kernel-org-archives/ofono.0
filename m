Content-Type: multipart/mixed; boundary="===============7580013888709364384=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 20/26] gatppp: add g_at_ppp_resume() prototype
Date: Fri, 01 Apr 2011 10:56:22 +0200
Message-ID: <1301648188-7208-21-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7580013888709364384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index e4e9f5f..fbf55b9 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -65,6 +65,7 @@ void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspen=
dFunc func,
 					gpointer user_data);
 void g_at_ppp_shutdown(GAtPPP *ppp);
 void g_at_ppp_suspend(GAtPPP *ppp);
+void g_at_ppp_resume(GAtPPP *ppp);
 void g_at_ppp_ref(GAtPPP *ppp);
 void g_at_ppp_unref(GAtPPP *ppp);
 =

-- =

1.7.1


--===============7580013888709364384==--

