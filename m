Content-Type: multipart/mixed; boundary="===============2002818643844915768=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: [PATCH v2 1/9] gps: define new dbus interface
Date: Tue, 11 Jan 2011 00:23:50 -0300
Message-ID: <1294716238-21218-2-git-send-email-rafael.zurita@profusion.mobi>
In-Reply-To: <1294716238-21218-1-git-send-email-rafael.zurita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2002818643844915768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/dbus.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/dbus.h b/include/dbus.h
index 12768f6..fb85771 100644
--- a/include/dbus.h
+++ b/include/dbus.h
@@ -54,6 +54,7 @@ extern "C" {
 #define OFONO_VOICECALL_MANAGER_INTERFACE "org.ofono.VoiceCallManager"
 #define OFONO_STK_INTERFACE OFONO_SERVICE ".SimToolkit"
 #define OFONO_SIM_APP_INTERFACE OFONO_SERVICE ".SimToolkitAgent"
+#define OFONO_LOCATION_REPORTING_INTERFACE OFONO_SERVICE ".LocationReporti=
ng"
 =

 /* CDMA Interfaces */
 #define OFONO_CDMA_VOICECALL_MANAGER_INTERFACE "org.ofono.cdma.VoiceCallMa=
nager"
-- =

1.7.2.3


--===============2002818643844915768==--

