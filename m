Content-Type: multipart/mixed; boundary="===============8444147510952932215=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 09/11] Driver API changed to accept DCS and any format string
Date: Wed, 01 Sep 2010 04:00:34 -0700
Message-ID: <1283338836-13572-9-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1283338836-13572-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8444147510952932215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/ussd.h |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/ussd.h b/include/ussd.h
index 96e04cb..e3b43f7 100644
--- a/include/ussd.h
+++ b/include/ussd.h
@@ -45,13 +45,15 @@ struct ofono_ussd_driver {
 	const char *name;
 	int (*probe)(struct ofono_ussd *ussd, unsigned int vendor, void *data);
 	void (*remove)(struct ofono_ussd *ussd);
-	void (*request)(struct ofono_ussd *ussd, const char *str,
-				ofono_ussd_cb_t, void *data);
+	void (*request)(struct ofono_ussd *ussd, int dcs,
+                    const unsigned char *str, int str_len,
+                    ofono_ussd_cb_t, void *data);
 	void (*cancel)(struct ofono_ussd *ussd,
 				ofono_ussd_cb_t cb, void *data);
 };
 =

-void ofono_ussd_notify(struct ofono_ussd *ussd, int status, const char *st=
r);
+void ofono_ussd_notify(struct ofono_ussd *ussd, int status, int dcs,
+                       const unsigned char *str, int str_len);
 =

 int ofono_ussd_driver_register(const struct ofono_ussd_driver *d);
 void ofono_ussd_driver_unregister(const struct ofono_ussd_driver *d);
-- =

1.7.0.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============8444147510952932215==--

