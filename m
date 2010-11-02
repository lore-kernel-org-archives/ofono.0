Content-Type: multipart/mixed; boundary="===============4381507748469949878=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 2/2] coding_style: Add case for enum as switch variable
Date: Tue, 02 Nov 2010 22:21:37 +0800
Message-ID: <1288707697-26374-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1288707697-26374-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4381507748469949878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/coding-style.txt |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index 9e5a811..6fa355e 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -173,6 +173,38 @@ enum animal_type {
 	ANIMAL_TYPE_TWO_LEGS =3D		2,
 };
 =

+M12: Enum as switch variable
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+If the variable of a switch is an enum, you must not include a default in
+switch body. The reason for this is: If later on you modify the enum by ad=
ding
+a new type, and forget to change the switch accordingly, the compiler will
+complain the new added type hasn't been handled.
+
+Example:
+
+enum animal_type {
+	ANIMAL_TYPE_FOUR_LEGS =3D		4,
+	ANIMAL_TYPE_EIGHT_LEGS =3D	8,
+	ANIMAL_TYPE_TWO_LEGS =3D		2,
+};
+
+enum animal_type t;
+
+switch (t) {
+case ANIMAL_TYPE_FOUR_LEGS:
+	...
+	break;
+case ANIMAL_TYPE_EIGHT_LEGS:
+	...
+	break;
+case ANIMAL_TYPE_TWO_LEGS:
+	...
+	break;
+default:  // wrong
+	break;
+}
+
 O1: Shorten the name
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 Better to use abbreviation, rather than full name, to name a variable,
-- =

1.7.2.3


--===============4381507748469949878==--

