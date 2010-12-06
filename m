Content-Type: multipart/mixed; boundary="===============4102114936033376589=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 14/14] test: add CNAP to test-ss-control-cs
Date: Mon, 06 Dec 2010 18:12:42 -0200
Message-ID: <1291666362-19128-14-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-13-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4102114936033376589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/test-ss-control-cs |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/test/test-ss-control-cs b/test/test-ss-control-cs
index e04a4a0..35db591 100755
--- a/test/test-ss-control-cs
+++ b/test/test-ss-control-cs
@@ -55,6 +55,9 @@ if __name__ =3D=3D "__main__":
 	print "Query CLIP"
 	print ss.Initiate("*#30#")
 =

+	print "Query CNAP"
+	print ss.Initiate("*#300#")
+
 	print "Query COLP"
 	print ss.Initiate("*#76#")
 =

-- =

1.7.3.2


--===============4102114936033376589==--

