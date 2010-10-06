Content-Type: multipart/mixed; boundary="===============2293523474776161030=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/3] voicecall: __ofono_voicecall_send_tone internal api.
Date: Wed, 06 Oct 2010 12:35:01 +0200
Message-ID: <1286361303-8712-2-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <1286361303-8712-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2293523474776161030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This provides a way for other atoms to send DTMF tones during a call.
---
 src/ofono.h     |    4 ++++
 src/voicecall.c |   16 ++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/src/ofono.h b/src/ofono.h
index 6c7f649..6efd9ac 100644
--- a/src/ofono.h
+++ b/src/ofono.h
@@ -218,6 +218,10 @@ int __ofono_voicecall_dial(struct ofono_voicecall *vc,
 				ofono_voicecall_dial_cb_t cb, void *user_data);
 void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
 =

+int __ofono_voicecall_send_tone(struct ofono_voicecall *vc,
+				const char *tone_str,
+				ofono_voicecall_cb_t cb, void *user_data);
+
 #include <ofono/sms.h>
 =

 struct sms;
diff --git a/src/voicecall.c b/src/voicecall.c
index 2833e64..5feb2eb 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2328,3 +2328,19 @@ void __ofono_voicecall_dial_cancel(struct ofono_voic=
ecall *vc)
 =

 	vc->dial_req->cb =3D NULL;
 }
+
+int __ofono_voicecall_send_tone(struct ofono_voicecall *vc,
+				const char *tone_str,
+				ofono_voicecall_cb_t cb, void *user_data)
+{
+	if (!vc->driver->send_tones)
+		return -ENOSYS;
+
+	/* Send DTMFs only if we have at least one connected call */
+	if (!voicecalls_can_dtmf(vc))
+		return -ENOENT;
+
+	vc->driver->send_tones(vc, tone_str, cb, user_data);
+
+	return 0;
+}
-- =

1.7.1.86.g0e460.dirty


--===============2293523474776161030==--

