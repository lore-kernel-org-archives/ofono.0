Content-Type: multipart/mixed; boundary="===============1315244759616136533=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/2] emulator: add defines for call,
 callsetup and callheld indicators
Date: Fri, 18 Mar 2011 17:10:47 +0100
Message-ID: <1300464648-11074-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1300464648-11074-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1315244759616136533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 71b7c24..5cd894b 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -36,6 +36,18 @@ extern "C" {
 #define OFONO_EMULATOR_IND_SERVICE "service"
 #define OFONO_EMULATOR_IND_SIGNAL "signal"
 =

+#define OFONO_EMULATOR_CALL_INACTIVE 0
+#define OFONO_EMULATOR_CALL_ACTIVE 1
+
+#define OFONO_EMULATOR_CALLSETUP_INACTIVE 0
+#define OFONO_EMULATOR_CALLSETUP_INCOMING 1
+#define OFONO_EMULATOR_CALLSETUP_OUTGOING 2
+#define OFONO_EMULATOR_CALLSETUP_ALERTING 3
+
+#define OFONO_EMULATOR_CALLHELD_NONE 0
+#define OFONO_EMULATOR_CALLHELD_MULTIPLE 1
+#define OFONO_EMULATOR_CALLHELD_ON_HOLD 2
+
 struct ofono_emulator;
 struct ofono_emulator_request;
 =

-- =

1.7.1


--===============1315244759616136533==--

