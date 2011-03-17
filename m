Content-Type: multipart/mixed; boundary="===============4456200002939081061=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH 1/4] emulator: add defines for call and callsetup indicators
Date: Thu, 17 Mar 2011 17:50:53 +0100
Message-ID: <1300380656-8757-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1300380656-8757-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4456200002939081061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 71b7c24..701decd 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -36,6 +36,14 @@ extern "C" {
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
 struct ofono_emulator;
 struct ofono_emulator_request;
 =

-- =

1.7.1


--===============4456200002939081061==--

