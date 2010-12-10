Content-Type: multipart/mixed; boundary="===============0947408102673091104=="
MIME-Version: 1.0
From: Antti Paila <antti.paila@nokia.com>
Subject: [PATCH 4/4 v2] plugins: Documentation for nettime plugin
Date: Fri, 10 Dec 2010 09:53:58 +0200
Message-ID: <1291967638-12371-5-git-send-email-antti.paila@nokia.com>
In-Reply-To: <1291967638-12371-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0947408102673091104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-time-api.txt |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)
 create mode 100644 doc/network-time-api.txt

diff --git a/doc/network-time-api.txt b/doc/network-time-api.txt
new file mode 100644
index 0000000..cb2b9d7
--- /dev/null
+++ b/doc/network-time-api.txt
@@ -0,0 +1,31 @@
+Network time hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.NetworkTime
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetNetworkTime()
+
+			Returns the network indicated time for the modem object.
+			See the properties section for the content of the dict.
+
+Signals		NetworkTimeChanged(dict)
+
+			This signal indicates the reception of network time.
+			See the properties section for the content of the dict.
+
+Properties	int64 UTC [readonly, optional]
+
+			Network time in seconds from epoch normalized to =

+			indication arrival timestamp. Reveicing entity obtains =

+			real time by adding the current time from monotonic
+			clock e.g. clock_gettime(CLOCK_MONOTONIC,...).
+
+		int32 Timezone [readonly]
+
+			Current timezone offset in seconds from UTC.
+
+		uint32 DST [readonly]
+
+			Current daylight saving setting in hours.
\ No newline at end of file
-- =

1.7.1


--===============0947408102673091104==--

