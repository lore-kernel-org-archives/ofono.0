Content-Type: multipart/mixed; boundary="===============2964332139096007230=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 5/7] include: replace set_attached with set_attach_policy
Date: Mon, 07 Feb 2011 16:03:10 +0200
Message-ID: <1297087392-31030-5-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201102071602.20179.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2964332139096007230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index 157a6f9..15c1080 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -41,7 +41,8 @@ struct ofono_gprs_driver {
 	int (*probe)(struct ofono_gprs *gprs, unsigned int vendor,
 			void *data);
 	void (*remove)(struct ofono_gprs *gprs);
-	void (*set_attached)(struct ofono_gprs *gprs, int attached,
+	void (*set_attach_policy)(struct ofono_gprs *gprs,
+				ofono_bool_t always_on,
 				ofono_gprs_cb_t cb, void *data);
 	void (*attached_status)(struct ofono_gprs *gprs,
 					ofono_gprs_status_cb_t cb, void *data);
-- =

1.7.1


--===============2964332139096007230==--

