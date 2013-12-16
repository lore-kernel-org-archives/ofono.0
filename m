Content-Type: multipart/mixed; boundary="===============4511823650125875130=="
MIME-Version: 1.0
From: KrzysztofX Wilk <krzysztofx.wilk@intel.com>
Subject: [PATCH 2/8] dbus: Define Siri DBUS Interface
Date: Mon, 16 Dec 2013 17:52:38 +0000
Message-ID: <1387216364-7138-3-git-send-email-krzysztofx.wilk@intel.com>
In-Reply-To: <1387216364-7138-1-git-send-email-krzysztofx.wilk@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4511823650125875130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dbus.h b/include/dbus.h
index 44faa7f..e7ccb0b 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -59,6 +59,7 @@ extern "C" {
 #define OFONO_GNSS_INTERFACE "org.ofono.AssistedSatelliteNavigation"
 #define OFONO_GNSS_POSR_AGENT_INTERFACE "org.ofono.PositioningRequestAgent"
 #define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
+#define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
 =

 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
-- =

1.7.11.7


--===============4511823650125875130==--

