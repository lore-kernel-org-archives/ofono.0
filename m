Content-Type: multipart/mixed; boundary="===============0282018655280892150=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 5/5] phonesim: connect call mangagement signals
Date: Wed, 11 May 2011 13:46:47 +0200
Message-ID: <1305114407-23796-6-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305114407-23796-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0282018655280892150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/phonesim.cpp |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index 6b45cf6..d3bd049 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -530,6 +530,10 @@ SimRules::SimRules( int fd, QObject *p,  const QString=
& filename, HardwareManipu
                  _callManager, SLOT(startIncomingCall(QString,QString,QStr=
ing)) );
         connect ( _callManager, SIGNAL( callStatesChanged( QList<CallInfo>=
 * ) ),
                   machine, SLOT( callManagement( QList<CallInfo> * ) ) );
+        connect ( machine, SIGNAL( stateChangedToAlerting() ), _callManage=
r,
+                SLOT( dialingToAlerting() ) );
+        connect ( machine, SIGNAL( stateChangedToConnected() ), _callManag=
er,
+                SLOT( dialingToConnected() ) );
     }
 =

     connect(this,SIGNAL(readyRead()),
-- =

1.7.1


--===============0282018655280892150==--

