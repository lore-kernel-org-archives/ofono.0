Content-Type: multipart/mixed; boundary="===============0305068589285407739=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: [PATCH v2 1/9] dbus: Add CDMA Voicecall Interface
Date: Fri, 17 Dec 2010 15:11:13 -0800
Message-ID: <1292627481-9109-2-git-send-email-dara.spieker-doyle@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0305068589285407739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 9e29afb..c527515 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -55,6 +55,9 @@ extern "C" {
 #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
 #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
 =

+/* CDMA Interfaces */
+#define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
+
 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
 					DBUS_TYPE_STRING_AS_STRING \
-- =

1.7.0.4


--===============0305068589285407739==--

