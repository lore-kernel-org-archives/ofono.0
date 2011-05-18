Content-Type: multipart/mixed; boundary="===============1110805558212581550=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH 1/5] controlbase: Add hangup button
Date: Wed, 18 May 2011 15:33:26 +0200
Message-ID: <1305725610-32602-2-git-send-email-nicolas.bertrand@linux.intel.com>
In-Reply-To: <1305725610-32602-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1110805558212581550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/controlbase.ui |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index 45b60f9..50315db 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -1410,6 +1410,13 @@ p, li { white-space: pre-wrap; }
            </property>
           </widget>
          </item>
+         <item>
+          <widget class=3D"QPushButton" name=3D"pbHangup">
+           <property name=3D"text">
+            <string>Hangup</string>
+           </property>
+          </widget>
+         </item>
         </layout>
        </item>
        <item>
-- =

1.7.1


--===============1110805558212581550==--

