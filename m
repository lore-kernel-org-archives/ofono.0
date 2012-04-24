Content-Type: multipart/mixed; boundary="===============7079415556618763611=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH] controlbase: Remove html property from teSMSText
Date: Tue, 24 Apr 2012 12:40:10 +0300
Message-ID: <1335260410-5798-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7079415556618763611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The content of this property adds a few extra newlines
into QTextEdit, which is probably not the intention.
---
 src/controlbase.ui |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/src/controlbase.ui b/src/controlbase.ui
index 50315db..ce675d2 100644
--- a/src/controlbase.ui
+++ b/src/controlbase.ui
@@ -746,19 +746,6 @@
             <property name=3D"tabChangesFocus">
              <bool>true</bool>
             </property>
-            <property name=3D"html">
-             <string>&lt;!DOCTYPE HTML PUBLIC &quot;-//W3C//DTD HTML 4.0//=
EN&quot; &quot;http://www.w3.org/TR/REC-html40/strict.dtd&quot;&gt;
-&lt;html&gt;&lt;head&gt;&lt;meta name=3D&quot;qrichtext&quot; content=3D&q=
uot;1&quot; /&gt;&lt;style type=3D&quot;text/css&quot;&gt;
-p, li { white-space: pre-wrap; }
-&lt;/style&gt;&lt;/head&gt;&lt;body style=3D&quot; font-family:'Sans Serif=
'; font-size:9pt; font-weight:400; font-style:normal;&quot;&gt;
-&lt;table border=3D&quot;0&quot; style=3D&quot;-qt-table-type: root; margi=
n-top:4px; margin-bottom:4px; margin-left:4px; margin-right:4px;&quot;&gt;
-&lt;tr&gt;
-&lt;td style=3D&quot;border: none;&quot;&gt;
-&lt;p style=3D&quot;-qt-paragraph-type:empty; margin-top:0px; margin-botto=
m:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0=
px;&quot;&gt;&lt;/p&gt;
-&lt;p style=3D&quot;-qt-paragraph-type:empty; margin-top:0px; margin-botto=
m:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0=
px;&quot;&gt;&lt;/p&gt;
-&lt;p style=3D&quot;-qt-paragraph-type:empty; margin-top:0px; margin-botto=
m:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0=
px;&quot;&gt;&lt;/p&gt;
-&lt;p style=3D&quot;-qt-paragraph-type:empty; margin-top:0px; margin-botto=
m:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0=
px;&quot;&gt;&lt;/p&gt;&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;&lt;/body&gt;&lt=
;/html&gt;</string>
-            </property>
            </widget>
           </item>
          </layout>
-- =

1.7.5.4


--===============7079415556618763611==--

