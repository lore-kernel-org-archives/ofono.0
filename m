Content-Type: multipart/mixed; boundary="===============8778315959235165634=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH v2 4/6] phonesim: Connect call status signal
Date: Mon, 02 May 2011 11:17:16 +0200
Message-ID: <1304327838-11164-5-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1304327838-11164-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8778315959235165634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/phonesim.cpp |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index a822cd9..6b45cf6 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -528,6 +528,8 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
     if ( machine ) {
         connect( machine, SIGNAL(startIncomingCall(QString,QString,QString=
)),
                  _callManager, SLOT(startIncomingCall(QString,QString,QStr=
ing)) );
+        connect ( _callManager, SIGNAL( callStatesChanged( QList<CallInfo>=
 * ) ),
+                  machine, SLOT( callManagement( QList<CallInfo> * ) ) );
     }
 =

     connect(this,SIGNAL(readyRead()),
-- =

1.7.1


--===============8778315959235165634==--

