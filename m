Content-Type: multipart/mixed; boundary="===============5624254349509797591=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 4/5 v3] nettime: Documentation
Date: Thu, 13 Jan 2011 11:49:34 +0200
Message-ID: <1294912175-12026-5-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1294912175-12026-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5624254349509797591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-time-api.txt |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 doc/network-time-api.txt

diff --git a/doc/network-time-api.txt b/doc/network-time-api.txt
new file mode 100644
index 0000000..bdefed7
--- /dev/null
+++ b/doc/network-time-api.txt
@@ -0,0 +1,36 @@
+Network time hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Interface	org.ofono.NetworkTime
+Object path	[variable]
+
+Methods		void Notify(dict info)
+
+			Notifies the service of current time and date
+			as notified by the cellular network.  The info
+			argument contains a dictionary with the
+			following possible keys:
+
+			int64 UTC [optional]
+				Network time in seconds from epoch
+				normalized to device boot time.
+				Reveicing entity obtains current real
+				time by adding the value from monotonic
+				clock e.g.
+				clock_gettime(CLOCK_MONOTONIC,...).
+
+			int32 Timezone [optional]
+				Current timezone offset in seconds from
+				UTC.
+
+			uint32 DST [optional]
+				Current daylight saving setting in
+				hours.
+
+			string MobileCountryCode
+				The Mobile country code of the
+				current network operator.
+
+			string MobileNetworkCode
+				The Mobile network code of the
+				current network operator.
-- =

1.7.1


--===============5624254349509797591==--

