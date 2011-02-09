Content-Type: multipart/mixed; boundary="===============9025145482839551671=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 5/7] include: replace set_attached with set_attach_policy
Date: Wed, 09 Feb 2011 16:28:55 +0200
Message-ID: <1297261737-20372-5-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1297261737-20372-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9025145482839551671==
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


--===============9025145482839551671==--

