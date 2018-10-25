Content-Type: multipart/mixed; boundary="===============8494310698251602363=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] doc/common-patterns.txt: initial version
Date: Thu, 25 Oct 2018 19:22:29 +0200
Message-ID: <20181025172229.3249-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8494310698251602363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/common-patterns.txt | 165 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 doc/common-patterns.txt

diff --git a/doc/common-patterns.txt b/doc/common-patterns.txt
new file mode 100644
index 00000000..dd615fcb
--- /dev/null
+++ b/doc/common-patterns.txt
@@ -0,0 +1,165 @@
+Every project has its own recursive patterns, and oFono is not an exceptio=
n.
+This document describes the most common ones found in the code.
+
+
+How do callbacks work
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Most of the time, the core atom for a given request calls a function in
+the atom, which generally executes some commands against the modem, and
+can then return the results to the core.
+
+For example:
+
+dbus call: lte/SetProperty(DefaultAPN)
+    |
+    v
+core: check APN validity, call the modem atom for execution in the modem
+	|
+	v
+atom: pipes for execution the command: AT+CGDCONT=3D0,"IP","MyNiceAPN"
+	    |
+[ break in the flow: the functions return back to the core, the dbus reque=
st ]
+[			is not answered at this time			     ]
+ 		...
+[GLibMain event loop schedules the command, it is executed, and modem answ=
ers]
+  	    |
+            v
+a callback function, registered along with the command, is now called
+	this processes the modem answers, and decides whether it is good or not
+	|
+	v
+a core callback function is now called. This was passed as an argument ear=
lier,
+when the atom was called, along with some context data (opaque info for the
+atom, but would contain the reference to the modem, the dbus pending call,=
 etc)
+    |
+    v
+the core can now answer the dbus message
+
+
+In the code, it looks like this:
+
+//core call:
+static DBusMessage *lte_set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct ofono_lte *lte =3D data;
+
+	/*
+	 * a block of code here processes the msg and fills the
+	 * lte->pending_info structure
+	 */
+
+	lte->driver->set_default_attach_info(lte, &lte->pending_info,
+					lte_set_default_attach_info_cb, lte);
+
+	return NULL;
+}
+// lte_set_default_attach_info_cb is the core callback function,
+// the lte structure is the parameter that it takes
+
+//atom:
+static void at_lte_set_default_attach_info(const struct ofono_lte *lte,
+			const struct ofono_lte_default_attach_info *info,
+			ofono_lte_cb_t cb, void *data)
+{
+	struct lte_driver_data *ldd =3D ofono_lte_get_data(lte);
+
+	// next line creates a structure for the in-atom callback
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+
+	if (g_at_chat_send(ldd->chat, "AT", NULL,
+					at_lte_set_default_attach_info_cb,
+					cbd, g_free) > 0)
+		return;
+
+	g_free(cbd);
+	CALLBACK_WITH_FAILURE(cb, data);
+}
+// here the structure is allocate dynamically, and since it is quite commo=
n,
+// the function g_at_chat_send accepts the last 3 parameters:
+// - in-atom callback function
+// - in-atom callback data
+// - release/disallocation function for dynamically-allocated callback data
+// NOTE: if g_at_chat_send fails, it does not free the memory, so it must =
be
+// done after the call.
+// Note also the callback to the core directly here if the g_at_chat_send =
fails.
+
+//atom callback:
+
+static void at_lte_set_default_attach_info_cb(gboolean ok, GAtResult *resu=
lt,
+							gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+
+	if (result =3D=3D NULL) {
+		CALLBACK_WITH_FAILURE(cbd->cb, cbd->data);
+		return;
+	}
+
+	decode_at_error(&error, g_at_result_final_response(result));
+	cbd->cb(&error, cbd->data);
+}
+// note that here cbd must not be released, it will be done by the function
+// calling at_lte_set_default_attach_info_cb when it returns.
+// note also that the core function will be executed before cbd is release=
d,
+// so the last line of the code is ok.
+
+
+use of the cb_data structure in the atoms
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+the cb_data can be used by creating the structure with cb_data_new,
+and then there are two possibilities:
+- use it in a single callback function, and destroy it with a call to
+  g_free.
+  Example:
+  - calling function:
+    struct cb_data *cbd =3D cb_data_new(cb, data);
+    if (g_at_chat_send(chat, buf, NULL, at_cgatt_cb, cbd, g_free) > 0)
+	return;
+    g_free(cbd);
+  - called function (here at_cgatt_cb):
+	static void at_cgatt_cb(gboolean ok, GAtResult *result,
+						gpointer user_data)
+	{
+		struct cb_data *cbd =3D user_data;
+		ofono_gprs_cb_t cb =3D cbd->cb;
+		struct ofono_error error;
+
+		decode_at_error(&error,
+				g_at_result_final_response(result));
+
+		cb(&error, cbd->data);
+	}
+    note the absence of explicit g_free(cbd);
+
+- pass it through a train of callback functions, adding a reference at
+  each pass cb_data_ref, and removing it with cb_data_unref.
+  the use of cb_data_ref would replace a new object creation, while the
+  use of cb_data_unref the use of g_free.
+  Example:
+  - calling function:
+	struct cb_data *cbd =3D cb_data_new(cb, data);
+	// no cb_ref at the creation
+	if (g_at_chat_send(chat, buf, NULL,
+				at_lte_set_default_attach_info_cb,
+				cbd, cb_data_unref) > 0)
+		goto end;
+	cb_data_unref(cbd);
+  - called function 1 (at_lte_set_default_attach_info_cb):
+	static void at_lte_set_default_attach_info_cb(gboolean ok,
+				GAtResult *result, gpointer user_data)
+	{
+		struct cb_data *cbd =3D user_data;
+
+		cbd =3D cb_data_ref(cbd);
+		if (g_at_chat_send(chat, buf, NULL,
+				at_cgatt_cb, cbd, cb_data_unref) > 0)
+			return;
+		cb_data_unref(cbd);
+	}
+  - called function 2 (at_cgatt_cb):
+    like above. no call to g_free or cb_data_unref. The terminal function
+    doesn't need to know about the reference scheme.
+
+
-- =

2.17.1


--===============8494310698251602363==--

