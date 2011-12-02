Content-Type: multipart/mixed; boundary="===============2412048055365310727=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 1/9] network: M9 coding style corrections
Date: Fri, 02 Dec 2011 13:10:29 +0200
Message-ID: <1322824237-10039-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322824237-10039-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2412048055365310727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/network.c b/src/network.c
index 19f9c00..e6636bb 100644
--- a/src/network.c
+++ b/src/network.c
@@ -37,6 +37,9 @@
 #include "util.h"
 #include "storage.h"
 =

+#define SETTINGS_STORE "netreg"
+#define SETTINGS_GROUP "Settings"
+
 #define NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN 0x1
 #define NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN 0x2
 =

@@ -46,11 +49,6 @@ enum network_registration_mode {
 	NETWORK_REGISTRATION_MODE_AUTO_ONLY =3D	5, /* Out of range of 27.007 */
 };
 =

-#define SETTINGS_STORE "netreg"
-#define SETTINGS_GROUP "Settings"
-
-static GSList *g_drivers =3D NULL;
-
 /* 27.007 Section 7.3 <stat> */
 enum operator_status {
 	OPERATOR_STATUS_UNKNOWN =3D	0,
@@ -96,6 +94,8 @@ struct network_operator_data {
 	struct ofono_netreg *netreg;
 };
 =

+static GSList *g_drivers =3D NULL;
+
 static const char *registration_mode_to_string(int mode)
 {
 	switch (mode) {
-- =

1.7.5.4


--===============2412048055365310727==--

