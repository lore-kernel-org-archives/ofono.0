Content-Type: multipart/mixed; boundary="===============5987771120611160546=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v5 1/8] cdmamodem: Define CDMA Network Registration atom.
Date: Wed, 03 Aug 2011 15:50:45 +0200
Message-ID: <1312379452-821-2-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312379452-821-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5987771120611160546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 4dd9db5..65bda72 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -63,6 +63,8 @@ extern "C" {
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
 #define OFONO_CDMA_MESSAGE_MANAGER_INTERFACE "org.ofono.cdma.MessageManage=
r"
 #define OFONO_CDMA_CONNECTION_MANAGER_INTERFACE "org.ofono.cdma.Connection=
Manager"
+#define OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE \
+					"org.ofono.cdma.NetworkRegistration"
 =

 /* Essentially a{sv} */
 #define OFONO_PROPERTIES_ARRAY_SIGNATURE DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STR=
ING \
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5987771120611160546==--

