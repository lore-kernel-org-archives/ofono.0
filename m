Content-Type: multipart/mixed; boundary="===============5085588946292554231=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] HACKING: add guidelines to patch submission
Date: Wed, 01 Dec 2010 13:46:44 -0200
Message-ID: <1291218404-3661-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5085588946292554231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 HACKING |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/HACKING b/HACKING
index e825185..3322554 100644
--- a/HACKING
+++ b/HACKING
@@ -91,3 +91,22 @@ Other debugging settings that can be toggled:
 =

  - Environment variable OFONO_AT_DEBUG (set to 1): enable AT commands
    debugging
+
+
+Submitting patches
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+If you fixed a bug or you want to add support for something, patches are
+welcome! In order to ease the inclusion of your patch, it's important to f=
ollow
+some rules, otherwise it will likely be rejected by maintainers:
+
+1) Do *not* add "Signed-off-by" lines in your commit messages. oFono does =
not
+use them, so including them is actually an error.
+
+2) Be sure to follow the coding style rules of oFono. They are listed in
+doc/coding-style.txt.
+
+3) Split your patch according to the top-level directories. E.g.: if you a=
dded
+a feature that touches files under 'include/', 'src/' and 'drivers/'
+directories, split in three separated patches, taking care not to
+break compilation.
-- =

1.7.3.2


--===============5085588946292554231==--

