Content-Type: multipart/mixed; boundary="===============2390915924678688309=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 4/6] phonesim: Connect call status signal
Date: Thu, 28 Apr 2011 11:49:37 +0200
Message-ID: <1303984179-8333-5-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1303984179-8333-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2390915924678688309==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/phonesim.cpp |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index a822cd9..cda32dd 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -528,6 +528,8 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
     if ( machine ) {
         connect( machine, SIGNAL(startIncomingCall(QString,QString,QString=
)),
                  _callManager, SLOT(startIncomingCall(QString,QString,QStr=
ing)) );
+        connect ( _callManager, SIGNAL( sendCallStatus( QList<CallInfo> * =
) ),
+                  machine, SLOT( callManagement( QList<CallInfo> * ) ) );
     }
 =

     connect(this,SIGNAL(readyRead()),
-- =

1.7.1


--===============2390915924678688309==--

