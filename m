Content-Type: multipart/mixed; boundary="===============7267510494303813652=="
MIME-Version: 1.0
From: Marti Raudsepp <marti@juffo.org>
Subject: [PATCH] systemd: prevent duplicate logging messages in journal
Date: Thu, 25 Oct 2012 21:37:30 +0300
Message-ID: <1351190250-15850-1-git-send-email-marti@juffo.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7267510494303813652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

By default, both stderr and syslog messages go to the systemd journal,
which results in duplicate messages being logged.

Thanks to Vinicius Costa Gomes for pointing out this problem.
---
 dundee/dundee.service.in | 1 +
 src/ofono.service.in     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/dundee/dundee.service.in b/dundee/dundee.service.in
index c57c618..82c5ef1 100644
--- a/dundee/dundee.service.in
+++ b/dundee/dundee.service.in
@@ -6,6 +6,7 @@ After=3Dsyslog.target
 Type=3Ddbus
 BusName=3Dorg.ofono.dundee
 ExecStart=3D@prefix@/sbin/dundee -n
+StandardError=3Dnull
 =

 [Install]
 WantedBy=3Dmulti-user.target
diff --git a/src/ofono.service.in b/src/ofono.service.in
index f4531a8..c24ac28 100644
--- a/src/ofono.service.in
+++ b/src/ofono.service.in
@@ -6,6 +6,7 @@ After=3Dsyslog.target
 Type=3Ddbus
 BusName=3Dorg.ofono
 ExecStart=3D@prefix@/sbin/ofonod -n
+StandardError=3Dnull
 =

 [Install]
 WantedBy=3Dmulti-user.target
-- =

1.8.0


--===============7267510494303813652==--

