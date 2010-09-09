Content-Type: multipart/mixed; boundary="===============7381943812894274054=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCHv2 2/6] Add message agent interface definition
Date: Thu, 09 Sep 2010 12:52:52 +0300
Message-ID: <1284025976-13294-3-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1284025976-13294-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7381943812894274054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 8cd214d..fb8109f 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -41,6 +41,7 @@ extern "C" {
 #define OFONO_CONNECTION_CONTEXT_INTERFACE "org.ofono.ConnectionContext"
 #define OFONO_CONNECTION_MANAGER_INTERFACE "org.ofono.ConnectionManager"
 #define OFONO_MESSAGE_MANAGER_INTERFACE "org.ofono.MessageManager"
+#define OFONO_MESSAGE_AGENT_INTERFACE "org.ofono.MessageAgent"
 #define OFONO_MESSAGE_WAITING_INTERFACE "org.ofono.MessageWaiting"
 #define OFONO_NETWORK_REGISTRATION_INTERFACE "org.ofono.NetworkRegistratio=
n"
 #define OFONO_NETWORK_OPERATOR_INTERFACE "org.ofono.NetworkOperator"
-- =

1.7.0.4


--===============7381943812894274054==--

