Content-Type: multipart/mixed; boundary="===============0378396785696110132=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v1 1/4] cdma-connman: Add dormant state notification API
Date: Thu, 08 Dec 2011 12:00:27 +0100
Message-ID: <1323342030-9175-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323342030-9175-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0378396785696110132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-connman.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/cdma-connman.h b/include/cdma-connman.h
index 7a115bf..d2ffa0f 100644
--- a/include/cdma-connman.h
+++ b/include/cdma-connman.h
@@ -66,6 +66,9 @@ void ofono_cdma_connman_driver_unregister(
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


--===============0378396785696110132==--

