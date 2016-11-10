Content-Type: multipart/mixed; boundary="===============6734400143056816135=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 1/9] include: add LTE dbus service define
Date: Thu, 10 Nov 2016 17:55:48 +0100
Message-ID: <1478796956-22500-2-git-send-email-dragos@endocode.com>
In-Reply-To: <1478796956-22500-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6734400143056816135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dbus.h b/include/dbus.h
index 99d45d6..cf68ae5 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -61,6 +61,7 @@ extern "C" {
 #define OFONO_HANDSFREE_INTERFACE OFONO_SERVICE ".Handsfree"
 #define OFONO_SIRI_INTERFACE OFONO_SERVICE ".Siri"
 #define OFONO_NETMON_INTERFACE OFONO_SERVICE ".NetworkMonitor"
+#define OFONO_LTE_INTERFACE OFONO_SERVICE ".LongTermEvolution"
 =

 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
-- =

2.7.4


--===============6734400143056816135==--

