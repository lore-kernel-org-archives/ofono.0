Content-Type: multipart/mixed; boundary="===============7108781663890281082=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 1/9] dbus: add gnss interface definition
Date: Tue, 08 Mar 2011 13:00:43 +0200
Message-ID: <1299582051-32701-2-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1299582051-32701-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7108781663890281082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 19a138a..bf3e8a4 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -56,6 +56,8 @@ extern "C" {
 #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
 #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
 #define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationReporti=
ng"
+#define OFONO_AS_NAVIGATION_INTERFACE "org.ofono.AssistedSatelliteNavigati=
on"
+#define OFONO_POSITIONING_REQUEST_INTERFACE "org.ofono.PositioningRequestA=
gent"
 =

 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
-- =

1.7.0.4


--===============7108781663890281082==--

