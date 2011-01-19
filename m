Content-Type: multipart/mixed; boundary="===============8363191101479152482=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] doc: use right description for CallSettings
Date: Tue, 18 Jan 2011 22:14:49 -0200
Message-ID: <1295396089-12631-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8363191101479152482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/features.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/features.txt b/doc/features.txt
index b11d92d..13854c4 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -299,7 +299,7 @@ Supplementary Services
 =

 - CNAP support.  The Calling Name Presentation supplementary service is
   supported by oFono.  One can query whether the service is provisioned in=
 the
-  network by using the CallSettings property.  If the network reports the
+  network by using the CallSettings interface.  If the network reports the
   calling name, it is presented on the Voicecall interface using the Name
   property.  If no calling name is given, the Name is empty.
 =

-- =

1.7.3.5


--===============8363191101479152482==--

