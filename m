Content-Type: multipart/mixed; boundary="===============6501463853073434485=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 03/12] gdbus: add argument info to methods and signals
Date: Sun, 20 May 2012 02:07:27 -0300
Message-ID: <1337490456-10941-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1337490456-10941-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6501463853073434485==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gdbus/gdbus.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a0583e6..e5e7938 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -85,16 +85,24 @@ typedef enum {
 typedef struct {
 	const char *name;
 	const char *signature;
+} GDBusArgInfo;
+
+typedef struct {
+	const char *name;
+	const char *signature;
 	const char *reply;
 	GDBusMethodFunction function;
 	GDBusMethodFlags flags;
 	unsigned int privilege;
+	const GDBusArgInfo *in_args;
+	const GDBusArgInfo *out_args;
 } GDBusMethodTable;
 =

 typedef struct {
 	const char *name;
 	const char *signature;
 	GDBusSignalFlags flags;
+	const GDBusArgInfo *args;
 } GDBusSignalTable;
 =

 typedef struct {
-- =

1.7.10.2


--===============6501463853073434485==--

