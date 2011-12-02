Content-Type: multipart/mixed; boundary="===============2381752639721159357=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 6/9] network: Add CPHS SPN, short-SPN flags
Date: Fri, 02 Dec 2011 13:10:34 +0200
Message-ID: <1322824237-10039-7-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1322824237-10039-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2381752639721159357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index fbcd449..6e08876 100644
--- a/src/network.c
+++ b/src/network.c
@@ -40,8 +40,12 @@
 #define SETTINGS_STORE "netreg"
 #define SETTINGS_GROUP "Settings"
 =

-#define NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN 0x1
-#define NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN 0x2
+enum network_registration_flag {
+	NETWORK_REGISTRATION_FLAG_HOME_SHOW_PLMN =3D	0x1,
+	NETWORK_REGISTRATION_FLAG_ROAMING_SHOW_SPN =3D	0x2,
+	NETWORK_REGISTRATION_FLAG_CPHS_SPN =3D		0x4,
+	NETWORK_REGISTRATION_FLAG_CPHS_SPN_SHORT =3D	0x8,
+};
 =

 enum network_registration_mode {
 	NETWORK_REGISTRATION_MODE_AUTO =3D	0,
-- =

1.7.5.4


--===============2381752639721159357==--

