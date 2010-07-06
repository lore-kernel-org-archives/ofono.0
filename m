Content-Type: multipart/mixed; boundary="===============2699054646675832848=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/14] Add Dbus interface names for STK.
Date: Wed, 07 Jul 2010 00:39:04 +0200
Message-ID: <1278455949-2823-10-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1278455949-2823-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2699054646675832848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index d988760..d959754 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -49,6 +49,8 @@ extern "C" {
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
 #define OFONO_DATA_CONNECTION_MANAGER_INTERFACE "org.ofono.DataConnectionM=
anager"
 #define OFONO_DATA_CONTEXT_INTERFACE "org.ofono.PrimaryDataContext"
+#define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
+#define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimApplicationAgent"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
-- =

1.7.1.86.g0e460.dirty


--===============2699054646675832848==--

