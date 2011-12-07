Content-Type: multipart/mixed; boundary="===============4999304021689255013=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 2/6] cdma-connman: Add dormant option configuration and
 notification
Date: Wed, 07 Dec 2011 17:05:47 +0100
Message-ID: <1323273951-24162-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323273951-24162-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4999304021689255013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-connman.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/cdma-connman.h b/include/cdma-connman.h
index 7a115bf..665afec 100644
--- a/include/cdma-connman.h
+++ b/include/cdma-connman.h
@@ -57,6 +57,10 @@ struct ofono_cdma_connman_driver {
 	void (*deactivate)(struct ofono_cdma_connman *cm,
 						ofono_cdma_connman_cb_t cb,
 						void *data);
+	void (*set_dormant_interval)(struct ofono_cdma_connman *cm,
+						int dormant_interval,
+						ofono_cdma_connman_cb_t cb,
+						void *data);
 };
 =

 int ofono_cdma_connman_driver_register(
@@ -66,6 +70,9 @@ void ofono_cdma_connman_driver_unregister(
 =

 void ofono_cdma_connman_deactivated(struct ofono_cdma_connman *cm);
 =

+void ofono_cdma_connman_dormant_state_notify(struct ofono_cdma_connman *cm,
+						ofono_bool_t dormant);
+
 struct ofono_cdma_connman *ofono_cdma_connman_create(
 						struct ofono_modem *modem,
 						unsigned int vendor,
-- =

1.7.1


--===============4999304021689255013==--

