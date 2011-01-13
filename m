Content-Type: multipart/mixed; boundary="===============3062713821882909405=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 3/6] Declaration for packet switched bearer notifications
Date: Thu, 13 Jan 2011 12:49:38 +0200
Message-ID: <1294915781-8330-3-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294915781-8330-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3062713821882909405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/gprs.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/gprs.h b/include/gprs.h
index ad7925c..157a6f9 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -59,6 +59,7 @@ void ofono_gprs_status_notify(struct ofono_gprs *gprs, in=
t status);
 void ofono_gprs_detached_notify(struct ofono_gprs *gprs);
 void ofono_gprs_suspend_notify(struct ofono_gprs *gprs, int cause);
 void ofono_gprs_resume_notify(struct ofono_gprs *gprs);
+void ofono_gprs_bearer_notify(struct ofono_gprs *gprs, int bearer);
 =

 int ofono_gprs_driver_register(const struct ofono_gprs_driver *d);
 void ofono_gprs_driver_unregister(const struct ofono_gprs_driver *d);
-- =

1.7.1


--===============3062713821882909405==--

