Content-Type: multipart/mixed; boundary="===============9006065583905838934=="
MIME-Version: 1.0
From: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
Subject: [PATCH] control: Make call table items non editable
Date: Thu, 12 May 2011 15:45:40 +0200
Message-ID: <1305207940-6500-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9006065583905838934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/control.cpp |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/src/control.cpp b/src/control.cpp
index e74aa7c..60f23f2 100644
--- a/src/control.cpp
+++ b/src/control.cpp
@@ -203,7 +203,11 @@ void ControlWidget::updateCallView( QString callParame=
ters [5], int row )
         ui->twCallMgt->insertRow( row );
 =

     for ( int i =3D 0; i < 5; i++ )
-        ui->twCallMgt->setItem( row, i, new QTableWidgetItem( callParamete=
rs[i] ) );
+    {
+        QTableWidgetItem *item =3D new QTableWidgetItem( callParameters[i]=
 );
+        item->setFlags( item->flags() & ~Qt::ItemIsEditable );
+        ui->twCallMgt->setItem( row, i, item );
+    }
 }
 =

 void Control::setPhoneNumber( const QString &number )
-- =

1.7.1


--===============9006065583905838934==--

