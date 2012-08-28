Content-Type: multipart/mixed; boundary="===============8671465119254991877=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 1/2] phonesim: Add methods to handle the 'immediate digit
 response' flag
Date: Tue, 28 Aug 2012 15:24:57 +0200
Message-ID: <1346160298-11307-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8671465119254991877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/qsimcommand.cpp |   30 ++++++++++++++++++++++++++++++
 src/qsimcommand.h   |    3 +++
 2 files changed, 33 insertions(+)

diff --git a/src/qsimcommand.cpp b/src/qsimcommand.cpp
index f5dbdf2..97e0b28 100644
--- a/src/qsimcommand.cpp
+++ b/src/qsimcommand.cpp
@@ -1312,6 +1312,36 @@ void QSimCommand::setWantYesNo( bool value )
 =

 =

 /*!
+    Returns true if \c GetInkey wants that the response is immediately sent
+    after key press.  The default value is false.
+
+    Applies to: \c GetInkey
+
+    \sa setWantImmediateResponse()
+*/
+bool QSimCommand::wantImmediateResponse() const
+{
+    if ( d->type =3D=3D QSimCommand::GetInkey )
+        return d->qualifierBit( 0x08 );
+    else
+        return false;
+}
+
+/*!
+    Sets the flag that determines if \c GetInkey wants that
+    the response is immediately sent after key press.
+
+    Applies to: \c GetInkey
+
+    \sa wantImmediateResponse()
+*/
+void QSimCommand::setWantImmediateResponse( bool value )
+{
+    if ( d->type =3D=3D QSimCommand::GetInkey )
+        dwrite()->setQualifierBit( 0x08, value );
+}
+
+/*!
     Returns the minimum text length for input.  The default value is 0.
 =

     Applies to: \c GetInput.
diff --git a/src/qsimcommand.h b/src/qsimcommand.h
index 3b34be9..2c1b423 100644
--- a/src/qsimcommand.h
+++ b/src/qsimcommand.h
@@ -292,6 +292,9 @@ public:
     bool echo() const;
     void setEcho( bool value );
 =

+    bool wantImmediateResponse() const;
+    void setWantImmediateResponse( bool value );
+
     QSimCommand::Disposition disposition() const;
     void setDisposition( QSimCommand::Disposition value );
 =

-- =

1.7.9.5


--===============8671465119254991877==--

