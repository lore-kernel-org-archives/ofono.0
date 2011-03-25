Content-Type: multipart/mixed; boundary="===============3434320505706201743=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 10/18] gatppp: add g_at_ppp_resume() prototype
Date: Fri, 25 Mar 2011 16:25:41 +0100
Message-ID: <1301066749-12052-11-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3434320505706201743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.h b/gatchat/gatppp.h
index 7835d1f..71e0afe 100644
--- a/gatchat/gatppp.h
+++ b/gatchat/gatppp.h
@@ -77,6 +77,8 @@ void g_at_ppp_set_recording(GAtPPP *ppp, const char *file=
name);
 void g_at_ppp_set_server_info(GAtPPP *ppp, const char *remote_ip,
 				const char *dns1, const char *dns2);
 =

+void g_at_ppp_resume(GAtPPP *ppp);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============3434320505706201743==--

