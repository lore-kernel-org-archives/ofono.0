Content-Type: multipart/mixed; boundary="===============3070537274797736600=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 2/7] text-telephony: define new dbus interface
Date: Tue, 23 Nov 2010 16:04:13 -0200
Message-ID: <1290535458-18786-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1290535458-18786-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3070537274797736600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 59b2aae..9e29afb 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -48,6 +48,7 @@ extern "C" {
 #define OFONO_PHONEBOOK_INTERFACE "org.ofono.Phonebook"
 #define OFONO_RADIO_SETTINGS_INTERFACE "org.ofono.RadioSettings"
 #define OFONO_AUDIO_SETTINGS_INTERFACE "org.ofono.AudioSettings"
+#define OFONO_TEXT_TELEPHONY_INTERFACE "org.ofono.TextTelephony"
 #define OFONO_SIM_MANAGER_INTERFACE "org.ofono.SimManager"
 #define OFONO_VOICECALL_INTERFACE "org.ofono.VoiceCall"
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
-- =

1.7.3.2


--===============3070537274797736600==--

