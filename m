Content-Type: multipart/mixed; boundary="===============8225929957218810882=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 2/5] hardwaremanipulator: Call state changed signals
Date: Wed, 11 May 2011 13:46:44 +0200
Message-ID: <1305114407-23796-3-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305114407-23796-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8225929957218810882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/hardwaremanipulator.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/hardwaremanipulator.h b/src/hardwaremanipulator.h
index ae8e716..9a82ca0 100644
--- a/src/hardwaremanipulator.h
+++ b/src/hardwaremanipulator.h
@@ -58,6 +58,8 @@ signals:
     void variableChanged(const QString &n, const QString &v);
     void switchTo(const QString &cmd);
     void startIncomingCall(const QString &number, const QString &called_nu=
mber, const QString &name);
+    void stateChangedToAlerting();
+    void stateChangedToConnected();
 =

 protected:
     virtual QString constructCBMessage(const QString &messageCode, int geo=
graphicalScope, const QString &updateNumber, const QString &channel,
-- =

1.7.1


--===============8225929957218810882==--

