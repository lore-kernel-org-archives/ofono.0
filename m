Content-Type: multipart/mixed; boundary="===============7122861855021758794=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/2] test: Tweak monitor-ofono to display CSSI/CSSU
 notifications
Date: Tue, 07 Aug 2012 16:02:31 +0200
Message-ID: <1344348152-20479-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7122861855021758794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/monitor-ofono |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/test/monitor-ofono b/test/monitor-ofono
index dcc5ff5..1f3fc56 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -161,6 +161,20 @@ if __name__ =3D=3D '__main__':
 						path_keyword=3D"path",
 						interface_keyword=3D"interface")
 =

+	bus.add_signal_receiver(value,
+				bus_name=3D"org.ofono",
+					signal_name =3D "Forwarded",
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
+	bus.add_signal_receiver(value,
+				bus_name=3D"org.ofono",
+					signal_name =3D "BarringActive",
+						member_keyword=3D"member",
+						path_keyword=3D"path",
+						interface_keyword=3D"interface")
+
 	for member in ["IncomingBroadcast", "EmergencyBroadcast",
 			"IncomingMessage", "ImmediateMessage"]:
 		bus.add_signal_receiver(message,
-- =

1.7.5.4


--===============7122861855021758794==--

