Content-Type: multipart/mixed; boundary="===============1851897248362010269=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/9] coding-style: add rule about checking NULL pointer
Date: Sat, 27 Nov 2010 13:38:57 -0200
Message-ID: <1290872345-15698-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1290872345-15698-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1851897248362010269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/coding-style.txt |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index eccdacc..76e6053 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -209,6 +209,27 @@ However if the enum comes from an external header file=
 outside ofono
 we cannot make any assumption of how the enum is defined and this
 rule might not apply.
 =

+M13: Check for pointer being NULL
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+When checking if a pointer or a return value is NULL, explicitly compare to
+NULL rather than use the shorter check with "!" operator.
+
+Example:
+1)
+array =3D g_try_new0(int, 20);
+if (!array)	// Wrong
+	return;
+
+2)
+if (!g_at_chat_get_slave(chat))	// Wrong
+	return -EINVAL;
+
+3)
+array =3D g_try_new0(int, 20);
+if (!array)	// Correct
+	return;
+
 O1: Shorten the name
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Better to use abbreviation, rather than full name, to name a variable,
-- =

1.7.3.2


--===============1851897248362010269==--

