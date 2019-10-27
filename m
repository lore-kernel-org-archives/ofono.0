Content-Type: multipart/mixed; boundary="===============3934102659017524582=="
MIME-Version: 1.0
From: Jonah =?unknown-8bit?q?Br=C3=BCchert?= <jbb.prv@gmx.de>
Subject: [PATCH phonesim v2 8/8] Use override at least in server header
Date: Sun, 27 Oct 2019 17:30:09 +0100
Message-ID: <20191027163009.13406-9-jbb.prv@gmx.de>
In-Reply-To: <20191027163009.13406-1-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3934102659017524582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Alexander Akulich <akulichalexander@gmail.com>

---
 src/server.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/server.h b/src/server.h
index 3342a90..9175359 100644
--- a/src/server.h
+++ b/src/server.h
@@ -32,15 +32,15 @@ class HardwareManipulatorFactory;
 class PhoneSimServer : public QTcpServer
 {
 public:
-    PhoneSimServer(const QString &, quint16 port, QObject *parent =3D 0);
-    ~PhoneSimServer();
+    PhoneSimServer(const QString &, quint16 port, QObject *parent =3D null=
ptr);
+    ~PhoneSimServer() override;

     void setHardwareManipulator(HardwareManipulatorFactory *f);

     SimRules *rules() const { return currentRules; }

 protected:
-    void incomingConnection(qintptr s);
+    void incomingConnection(qintptr s) override;

 private:
     QString filename;
--
2.23.0

--===============3934102659017524582==--

