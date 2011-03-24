Content-Type: multipart/mixed; boundary="===============8225009666088078038=="
MIME-Version: 1.0
From: Jarko Poutiainen <jarko.poutiainen@tieto.com>
Subject: [PATCH 01/12] dbus: add gnss interface definition
Date: Thu, 24 Mar 2011 15:46:25 +0200
Message-ID: <1300974396-15801-2-git-send-email-jarko.poutiainen@tieto.com>
In-Reply-To: <1300974396-15801-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8225009666088078038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 38864fb..4dd9db5 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -56,6 +56,8 @@ extern "C" {
 #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
 #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
 #define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationReporti=
ng"
+#define OFONO_GNSS_INTERFACE "org.ofono.AssistedSatelliteNavigation"
+#define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAgent"
 =

 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
-- =

1.7.0.4


--===============8225009666088078038==--

