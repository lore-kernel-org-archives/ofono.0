Content-Type: multipart/mixed; boundary="===============7760336675625252936=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH 1/3] gprs: Add list_active_contexts
Date: Mon, 12 Aug 2019 22:18:24 +0200
Message-ID: <20190812201826.28535-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7760336675625252936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

This is useful for instance during startup where early
activated contexts can be listed at a suitable point in time.
---
 include/gprs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/gprs.h b/include/gprs.h
index 988d6102..c276517f 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -45,6 +45,8 @@ struct ofono_gprs_driver {
 				ofono_gprs_cb_t cb, void *data);
 	void (*attached_status)(struct ofono_gprs *gprs,
 					ofono_gprs_status_cb_t cb, void *data);
+	void (*list_active_contexts)(struct ofono_gprs *gprs,
+					ofono_gprs_status_cb_t cb, void *data);
 };
 =

 enum gprs_suspend_cause {
-- =

2.20.1


--===============7760336675625252936==--

