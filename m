Content-Type: multipart/mixed; boundary="===============3148960654598299229=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject: [PATCH] test: Create simple-handsfree-audio-agent
Date: Mon, 25 Feb 2013 11:17:55 -0300
Message-ID: <1361801875-7297-1-git-send-email-jprvita@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3148960654598299229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This python tool implements the org.ofono.HandsfreeAudioAgent interface,
dealing with the SCO file descriptor passed by the Handsfree Audio
Manager.
---
 test/simple-handsfree-audio-agent | 100 ++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 100 insertions(+)
 create mode 100755 test/simple-handsfree-audio-agent

diff --git a/test/simple-handsfree-audio-agent b/test/simple-handsfree-audi=
o-agent
new file mode 100755
index 0000000..7b117f3
--- /dev/null
+++ b/test/simple-handsfree-audio-agent
@@ -0,0 +1,100 @@
+#!/usr/bin/python
+
+from __future__ import absolute_import, print_function, unicode_literals
+
+import sys
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+import gobject
+import os
+import glib
+
+OFONO_SERVICE =3D "org.ofono"
+HF_AGENT_IFACE =3D "org.ofono.HandsfreeAudioAgent"
+HF_AGENT_PATH =3D "/test/hf"
+HF_MANAGER_IFACE =3D "org.ofono.HandsfreeAudioManager"
+HF_MANAGER_PATH =3D "/"
+
+HFP_HF_UUID =3D "0000111E-0000-1000-8000-00805F9B34FB"
+CVSD_CODEC =3D dbus.Byte(0x01)
+MSBC_CODEC =3D dbus.Byte(0x02)
+
+
+def terminate():
+    print("Terminating")
+    in_file.close()
+    mainloop.quit()
+
+
+def sco_cb(fd, condition):
+    print("sco_cb(%s, %s)" % (fd, condition))
+
+    if (condition & glib.IO_ERR):
+        print("SCO error")
+        return False
+
+    if (condition & glib.IO_HUP):
+        print("SCO closed")
+        return False
+
+    if (condition & glib.IO_IN):
+        buf =3D fd.read()
+        print("Read %d bytes from SCO channel" % len(buf))
+        in_file.write(buf)
+
+    return True
+
+
+class HFAgent(dbus.service.Object):
+
+    def __init__(self, path, uuid, codecs):
+        self.path =3D path
+        self.uuid =3D uuid
+        self.codecs =3D codecs
+        dbus.service.Object.__init__(self, dbus.SystemBus(), self.path)
+        print("Agent created on %s" % self.path)
+        print(self.Introspect(self.path, self.connection), end=3D"")
+
+    def register(self):
+        obj =3D self.connection.get_object(OFONO_SERVICE, HF_MANAGER_PATH)
+        manager =3D dbus.Interface(obj, HF_MANAGER_IFACE)
+        manager.Register(self.path, self.codecs)
+        print("Agent registered with " + OFONO_SERVICE)
+
+    # D-Bus methods
+    @dbus.service.method(HF_AGENT_IFACE)
+    def Release(self):
+        print("Release()")
+        terminate()
+
+    @dbus.service.method(HF_AGENT_IFACE, in_signature=3D"ohy")
+    def NewConnection(self, card_path, sco_fd, codec):
+	self.fd =3D sco_fd.take()
+        print("NewConnection(%s, %d, %d)" % (card_path, self.fd, codec))
+        self.sco =3D os.fdopen(self.fd, "rb")
+        buf =3D self.sco.read()
+        print("Read %d bytes from SCO channel" % len(buf))
+        glib.io_add_watch(self.sco, glib.IO_IN | glib.IO_ERR | glib.IO_HUP=
, sco_cb)
+
+
+if __name__ =3D=3D '__main__':
+
+    if (len(sys.argv) < 2):
+        print("Usage: %s <file to dump audio to>" %
+              (sys.argv[0]))
+        sys.exit(1)
+
+    in_file =3D open(sys.argv[1], "wb")
+
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+
+    agent =3D HFAgent(HF_AGENT_PATH, HFP_HF_UUID, [CVSD_CODEC, MSBC_CODEC])
+    agent.register()
+
+    try:
+	mainloop =3D gobject.MainLoop()
+        mainloop.run()
+    except KeyboardInterrupt:
+        print("Keyboard interrupted")
+        terminate()
-- =

1.7.11.7


--===============3148960654598299229==--

