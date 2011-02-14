Content-Type: multipart/mixed; boundary="===============6973760016358761795=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 1/5] cell-info: CellInfo DBUS interface definition
Date: Mon, 14 Feb 2011 16:56:48 +0200
Message-ID: <1297695412-22259-2-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1297695412-22259-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6973760016358761795==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 19a138a..52514bb 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -46,6 +46,7 @@ extern "C" {
 #define OFONO_SUPPLEMENTARY_SERVICES_INTERFACE "org.ofono.SupplementarySer=
vices"
 #define OFONO_NETWORK_REGISTRATION_INTERFACE "org.ofono.NetworkRegistratio=
n"
 #define OFONO_NETWORK_OPERATOR_INTERFACE "org.ofono.NetworkOperator"
+#define OFONO_CELL_INFO_INTERFACE "org.ofono.NeighborCellInfo"
 #define OFONO_PHONEBOOK_INTERFACE "org.ofono.Phonebook"
 #define OFONO_RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
 #define OFONO_AUDIO_SETTINGS_INTERFACE "org.ofono.AudioSettings"
-- =

1.7.1


--===============6973760016358761795==--

