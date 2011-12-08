Content-Type: multipart/mixed; boundary="===============0436014204900144494=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 02/12] ofono.h: add cdma-providers
Date: Thu, 08 Dec 2011 15:49:53 +0100
Message-ID: <1323355803-22096-3-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323355803-22096-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0436014204900144494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ofono.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index bfb534d..a26c06d 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -487,6 +487,10 @@ void __ofono_gprs_provision_free_settings(
 #include <ofono/gnss.h>
 #include <ofono/cdma-sms.h>
 #include <ofono/cdma-netreg.h>
+
+#include <ofono/cdma-providers.h>
+ofono_bool_t __ofono_cdma_providers_get_name(const char *sid, char **name);
+
 #include <ofono/private-network.h>
 =

 void __ofono_private_network_release(int id);
-- =

1.7.1


--===============0436014204900144494==--

