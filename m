Content-Type: multipart/mixed; boundary="===============1260602885756211099=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 1/3] emulator: Add API to force indicator event
Date: Wed, 14 Mar 2012 17:00:51 +0100
Message-ID: <1331740853-3994-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1260602885756211099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For AT+CHLD=3D2, +CIEV unsollicited event for callheld should be sent even
if it does not change
---
 include/emulator.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 5cd894b..39f4ad7 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -105,6 +105,9 @@ enum ofono_emulator_request_type ofono_emulator_request=
_get_type(
 void ofono_emulator_set_indicator(struct ofono_emulator *em,
 					const char *name, int value);
 =

+void ofono_emulator_set_indicator_forced(struct ofono_emulator *em,
+					const char *name, int value);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============1260602885756211099==--

