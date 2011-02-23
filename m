Content-Type: multipart/mixed; boundary="===============2194038364895686236=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/3] emulator: add indicator support API
Date: Wed, 23 Feb 2011 16:48:48 +0100
Message-ID: <1298476130-8969-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1298476130-8969-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2194038364895686236==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 12477f0..71b7c24 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -28,6 +28,14 @@ extern "C" {
 =

 #include <ofono/types.h>
 =

+#define OFONO_EMULATOR_IND_BATTERY "battchg"
+#define OFONO_EMULATOR_IND_CALL "call"
+#define OFONO_EMULATOR_IND_CALLHELD "callheld"
+#define OFONO_EMULATOR_IND_CALLSETUP "callsetup"
+#define OFONO_EMULATOR_IND_ROAMING "roam"
+#define OFONO_EMULATOR_IND_SERVICE "service"
+#define OFONO_EMULATOR_IND_SIGNAL "signal"
+
 struct ofono_emulator;
 struct ofono_emulator_request;
 =

@@ -82,6 +90,9 @@ const char *ofono_emulator_request_get_raw(struct ofono_e=
mulator_request *req);
 enum ofono_emulator_request_type ofono_emulator_request_get_type(
 					struct ofono_emulator_request *req);
 =

+void ofono_emulator_set_indicator(struct ofono_emulator *em,
+					const char *name, int value);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============2194038364895686236==--

