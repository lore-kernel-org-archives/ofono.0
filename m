Content-Type: multipart/mixed; boundary="===============8555635321798065701=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 08/11] Declaration for packet switched bearer notifications
Date: Tue, 11 Jan 2011 16:08:36 +0200
Message-ID: <1294754919-9687-8-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8555635321798065701==
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


--===============8555635321798065701==--

