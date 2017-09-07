Content-Type: multipart/mixed; boundary="===============4661645079473424391=="
MIME-Version: 1.0
From: Nishanth V <nishanth.v@intel.com>
Subject: [PATCH 1/7] netmon: modified api.txt for network monitor agent
Date: Thu, 07 Sep 2017 09:53:14 +0530
Message-ID: <1504758200-18624-1-git-send-email-nishanth.v@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4661645079473424391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

added new DBUS methods RegisterAgent and UnregisterAgent to
Networkmonitor interface so that any client of ofono can register for
serving cell updates. Added new agent interface NetworkMonitorAgent
with two methods, ServingCellInformationChanged and Release.
---
 doc/networkmonitor-api.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
index ddace7e..0855329 100644
--- a/doc/networkmonitor-api.txt
+++ b/doc/networkmonitor-api.txt
@@ -22,6 +22,34 @@ Methods		a{sv} GetServingCellInformation()
 			are available, their valid value ranges and
 			applicability to different cell types.
 =

+		void RegisterAgent(object path)
+
+			Registers an agent which will be called whenever the
+			modem registers to or moves to a new cell.
+
+		void UnregisterAgent(object path)
+
+			Unregisters an agent.
+
+NetworkMonitorAgent Hierarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	org.ofono.NetworkMonitorAgent
+Object path	freely definable
+
+Methods		void ServingCellInformationChanged(a{sv})
+
+			This method is called whenever the serving cell
+			information has been updated.
+
+			Possible Errors: None
+
+		void Release() [noreply]
+
+			Agent is being released, possibly because of oFono
+			terminating, NetworkMonitor interface is being torn
+			down or modem off.  No UnregisterAgent call is needed.
 =

 Network Monitor Property Types
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
-- =

1.9.1


--===============4661645079473424391==--

