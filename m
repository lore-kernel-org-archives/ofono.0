Content-Type: multipart/mixed; boundary="===============0431478129124334642=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 1/5 v2] Cell-info: CellInfo DBUS interface definition
Date: Tue, 04 Jan 2011 16:36:55 +0200
Message-ID: <1294151819-3300-2-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1294151819-3300-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0431478129124334642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    1 +
 src/ofono.h    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index c527515..98839cc 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -45,6 +45,7 @@ extern "C" {
 #define OFONO_MESSAGE_WAITING_INTERFACE "org.ofono.MessageWaiting"
 #define OFONO_NETWORK_REGISTRATION_INTERFACE "org.ofono.NetworkRegistratio=
n"
 #define OFONO_NETWORK_OPERATOR_INTERFACE "org.ofono.NetworkOperator"
+#define OFONO_CELL_INFO_INTERFACE "org.ofono.CellInfo"
 #define OFONO_PHONEBOOK_INTERFACE "org.ofono.Phonebook"
 #define OFONO_RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
 #define OFONO_AUDIO_SETTINGS_INTERFACE "org.ofono.AudioSettings"
diff --git a/src/ofono.h b/src/ofono.h
index cab70cd..820e3a3 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -127,6 +127,7 @@ enum ofono_atom_type {
 	OFONO_ATOM_TYPE_NETTIME =3D 21,
 	OFONO_ATOM_TYPE_CTM =3D 22,
 	OFONO_ATOM_TYPE_CDMA_VOICECALL_MANAGER =3D 23,
+	OFONO_ATOM_TYPE_CELL_INFO =3D 24,
 };
 =

 enum ofono_atom_watch_condition {
-- =

1.7.1


--===============0431478129124334642==--

