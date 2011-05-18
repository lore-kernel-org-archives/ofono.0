Content-Type: multipart/mixed; boundary="===============5874664000722469771=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 5/5] phonesim: Connect hangup signal
Date: Wed, 18 May 2011 15:33:30 +0200
Message-ID: <1305725610-32602-6-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305725610-32602-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5874664000722469771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/phonesim.cpp |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/src/phonesim.cpp b/src/phonesim.cpp
index d3bd049..aa49f46 100644
--- a/src/phonesim.cpp
+++ b/src/phonesim.cpp
@@ -534,6 +534,8 @@ SimRules::SimRules( int fd, QObject *p,  const QString&=
 filename, HardwareManipu
                 SLOT( dialingToAlerting() ) );
         connect ( machine, SIGNAL( stateChangedToConnected() ), _callManag=
er,
                 SLOT( dialingToConnected() ) );
+        connect ( machine, SIGNAL( stateChangedToHangup( int ) ), _callMan=
ager,
+                SLOT( hangupRemote( int ) ) );
     }
 =

     connect(this,SIGNAL(readyRead()),
-- =

1.7.1


--===============5874664000722469771==--

