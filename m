Content-Type: multipart/mixed; boundary="===============5519435989688303068=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Danis <frederic.danis@linux.intel.com>
Subject: [PATCH v2 4/8] emulator: add incoming call API
Date: Thu, 07 Apr 2011 18:33:56 +0200
Message-ID: <1302194040-18811-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1302194040-18811-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5519435989688303068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/emulator.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/emulator.h b/include/emulator.h
index 5cd894b..55e3b9c 100644
--- a/include/emulator.h
+++ b/include/emulator.h
@@ -105,6 +105,9 @@ enum ofono_emulator_request_type ofono_emulator_request=
_get_type(
 void ofono_emulator_set_indicator(struct ofono_emulator *em,
 					const char *name, int value);
 =

+void ofono_emulator_incoming_call(struct ofono_emulator *em,
+					struct ofono_call *call);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============5519435989688303068==--

