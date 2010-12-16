Content-Type: multipart/mixed; boundary="===============4849665807225199112=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH 1/8] gps: define new dbus interface
Date: Thu, 16 Dec 2010 17:30:16 -0300
Message-ID: <1292531423-22316-2-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1292531423-22316-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4849665807225199112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 9e29afb..48e8ac4 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -54,6 +54,7 @@ extern "C" {
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
 #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
 #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
+#define OFONO_GPS_INTERFACE OFONO_SERVICE ".Gps"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
-- =

1.7.2.3


--===============4849665807225199112==--

