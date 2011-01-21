Content-Type: multipart/mixed; boundary="===============6401434892758086414=="
MIME-Version: 1.0
From: christian.lam@nokia.com
Subject: [PATCH 1/7] dbus: add CDMA Connection Manager interface
Date: Fri, 21 Jan 2011 15:06:44 -0800
Message-ID: <1295651210-22922-2-git-send-email-christian.lam@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6401434892758086414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christian Lam <christian.lam@nokia.com>

---
 include/dbus.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 83a0590..6f436ca 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -59,6 +59,7 @@ extern "C" {
 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
 #define OFONO_CDMA_MESSAGE_MANAGER_INTERFACE "org.ofono.cdma.MessageManage=
r"
+#define OFONO_CDMA_CONNECTION_MANAGER_INTERFACE "org.ofono.cdma.Connection=
Manager"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
-- =

1.7.0.4


--===============6401434892758086414==--

