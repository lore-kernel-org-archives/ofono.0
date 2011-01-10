Content-Type: multipart/mixed; boundary="===============6743777336032705933=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 07/10] Declaration for packet switched bearer notifications
Date: Mon, 10 Jan 2011 15:15:22 +0200
Message-ID: <1294665325-11937-7-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201101101515.04596.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6743777336032705933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index 1c1d116..cd62f2f 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -59,6 +59,8 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs, in=
t status, int tech);
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
 void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
 void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
+void ofono_gprs_bearer_notify(struct ofono_gprs *gprs,
+				unsigned int cid, int bearer);
 =

 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
 void ofono_gprs_driver_unregister(const struct ofono_gprs_driver *d);
-- =

1.7.1


--===============6743777336032705933==--

