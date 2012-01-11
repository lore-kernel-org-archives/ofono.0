Content-Type: multipart/mixed; boundary="===============5327805696914756066=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH v4 3/3] Adding a short description for usage of SIM900 plugin.
Date: Wed, 11 Jan 2012 17:59:03 +0400
Message-ID: <1326290343-21973-3-git-send-email-r.r.zaripov@gmail.com>
In-Reply-To: <1326290343-21973-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5327805696914756066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

Adding a short description for usage of SIM900 plugin.

---
 doc/sim900-modem.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 doc/sim900-modem.txt

diff --git a/doc/sim900-modem.txt b/doc/sim900-modem.txt
new file mode 100644
index 0000000..b0c1871
--- /dev/null
+++ b/doc/sim900-modem.txt
@@ -0,0 +1,12 @@
+SIM900 modem usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+To enable SIM900 module support you need to put the following
+udev rule into appropriate file in /{etc,lib}/udev/rules.d:
+
+KERNEL=3D=3D"gsmtty3", ENV{OFONO_DRIVER}=3D"sim900"
+
+On the i-Tetra tracking device, the SIM900 is accessed
+via N_GSM mux device. We use ofono as SMS message
+service and incoming voice calls service, so we
+use /dev/gsmtty3 provided by N_GSM mux.
-- =

1.7.7.3


--===============5327805696914756066==--

