Content-Type: multipart/mixed; boundary="===============6779775212497083391=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 4/7] Add message agent interface definition
Date: Mon, 27 Sep 2010 19:54:16 +0300
Message-ID: <1285606459-1297-5-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1285606459-1297-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6779775212497083391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 363bae2..bf945f1 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -42,6 +42,7 @@ extern "C" {
 #define OFONO_CONNECTION_MANAGER_INTERFACE "org.ofono.ConnectionManager"
 #define OFONO_MESSAGE_MANAGER_INTERFACE "org.ofono.MessageManager"
 #define OFONO_MESSAGE_INTERFACE "org.ofono.Message"
+#define OFONO_MESSAGE_AGENT_INTERFACE "org.ofono.MessageAgent"
 #define OFONO_MESSAGE_WAITING_INTERFACE "org.ofono.MessageWaiting"
 #define OFONO_NETWORK_REGISTRATION_INTERFACE "org.ofono.NetworkRegistratio=
n"
 #define OFONO_NETWORK_OPERATOR_INTERFACE "org.ofono.NetworkOperator"
-- =

1.7.0.4


--===============6779775212497083391==--

