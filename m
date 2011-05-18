Content-Type: multipart/mixed; boundary="===============9183687230539015558=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 3/5] hardwaremanipulator: add hangup signal
Date: Wed, 18 May 2011 15:33:28 +0200
Message-ID: <1305725610-32602-4-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305725610-32602-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9183687230539015558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hardwaremanipulator.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index 9a82ca0..881125e 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -60,6 +60,7 @@ signals:
     void startIncomingCall(const QString &number, const QString &called_nu=
mber, const QString &name);
     void stateChangedToAlerting();
     void stateChangedToConnected();
+    void stateChangedToHangup( int callId );
 =

 protected:
     virtual QString constructCBMessage(const QString &messageCode, int geo=
graphicalScope, const QString &updateNumber, const QString &channel,
-- =

1.7.1


--===============9183687230539015558==--

