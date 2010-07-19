Content-Type: multipart/mixed; boundary="===============1732994031522175667=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/4] Add coding style document
Date: Mon, 19 Jul 2010 14:19:26 +0800
Message-ID: <1279520369-13214-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1732994031522175667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/coding_style.txt |  151 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100644 doc/coding_style.txt

diff --git a/doc/coding_style.txt b/doc/coding_style.txt
new file mode 100644
index 0000000..f6c58f2
--- /dev/null
+++ b/doc/coding_style.txt
@@ -0,0 +1,151 @@
+=EF=BB=BFEvery project has its coding style, and oFono is not an exception=
. This
+document describes the preferred coding style for oFono code, in order to =
keep
+some level of consistency among developers so that code can be easily
+understood and maintained, and also to help your code survive under
+maintainer's fastidious eyes so that you can get a passport for your patch
+ASAP.
+
+First of all, oFono coding style must follow every rule for Linux kernel
+(http://www.kernel.org/doc/Documentation/CodingStyle). There also exists a=
 tool
+named checkpatch.pl to help you check the compliance with it. Just type
+"checkpatch.pl --no-tree patch_name" to check your patch. In theory, you n=
eed
+to clean up all the warnings and errors except this one: "ERROR: Missing
+Signed-off-by: line(s)". However, sometimes, the warning of exceeding maxi=
mum
+characters for a line (80 characters) can be ignored.
+
+Besides the kernel coding style above, oFono has special flavors for its o=
wn.
+Some of them are mandatory (marked as 'M'), while some others are optional
+(marked as 'O'), but nice to have.
+
+M1: Blank line before if statement
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+There should be a blank line before if statement unless the if is nested a=
nd
+not preceded by an expression or variable declaration.
+
+Example:
+1)
+a =3D 1;
+if (a) {  // correct
+
+2)
+a =3D 1;
+if (b) {  // wrong
+
+3)
+if (a) {
+	if (b)  // correct
+
+
+M2: Multiple line comment
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+If your comments have more then one line, please start it from the second =
line.
+
+Example:
+/*
+ * first line comment	// correct
+ * ...
+ * last line comment
+ */
+
+
+M3: Space before and after operator
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+There should be a space before and after each operator.
+
+Example:
+a + b;  // correct
+
+
+M4: Long condition
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If your condition in if, while, for statement is too long to fit in one li=
ne,
+the new line needs to be indented not aligned with the body.
+
+Example:
+1)
+if (call->status =3D=3D CALL_STATUS_ACTIVE ||
+	call->status =3D=3D CALL_STATUS_HELD) {  // wrong
+	ofono_dbus_dict_append();
+
+2)
+if (call->status =3D=3D CALL_STATUS_ACTIVE ||
+		call->status =3D=3D CALL_STATUS_HELD) {  // correct
+	ofono_dbus_dict_append();
+
+
+M5: Git commit message 50/72 formatting
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The commit message header should be within 50 characters. And if you have
+detailed explanatory text, wrap it to 72 character.
+
+
+M6: Space when doing type casting
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+There should be a space between new type and variable.
+
+Example:
+1)
+a =3D (int *)b;  // wrong
+2)
+a =3D (int *) b;  // correct
+
+
+M7: Don't initialize variable unnecessarily
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+When declaring a variable, try not to initialize it unless necessary.
+
+Example:
+int i =3D 1;  // wrong
+
+for (i =3D 0; i < 3; i++) {
+}
+
+
+M8: Use g_try_malloc instead of g_malloc
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+When g_malloc fails, the whole program would exit. Most of time, this is n=
ot
+the expected behavior, and you may want to use g_try_malloc instead.
+
+Example:
+additional =3D g_try_malloc(len - 1);  // correct
+if (additional =3D=3D NULL)
+	return FALSE;
+
+
+O1: Shorten the name
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Better to use abbreviation, rather than full name, to name a variable,
+function, struct, etc.
+
+Example:
+supplementary_service  // worse
+ss  // better
+
+
+O2: Try to avoid complex if body
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+It's better not to have a complicated statement for if. You may judge its
+contrary condition and return | break | continue | goto ASAP.
+
+Example:
+1)
+if @ {  // worse
+	struct voicecall *v;
+	call =3D synthesize_outgoing_call(vc, vc->pending);
+	v =3D voicecall_create(vc, call);
+	v->detect_time =3D time(NULL);
+	DBG("Registering new call: %d", call->id);
+	voicecall_dbus_register(v);
+} else
+	return;
+
+2)
+if (!a)
+	return;
+
+struct voicecall *v;
+call =3D synthesize_outgoing_call(vc, vc->pending);
+v =3D voicecall_create(vc, call);
+v->detect_time =3D time(NULL);
+DBG("Registering new call: %d", call->id);
+voicecall_dbus_register(v);
-- =

1.7.0.4


--===============1732994031522175667==--

