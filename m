Content-Type: multipart/mixed; boundary="===============1055851982699633517=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [fix-isi-udev PATCH 0/3] Improve udev with isi
Date: Mon, 04 Oct 2010 16:11:03 +0300
Message-ID: <1286197866-19572-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1055851982699633517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

Here are three patches for udev. For a reason or another, the current
ofono.rules does not work very well in Ubuntu 10.04. The "isigen" driver
is available when the device is added, but not when the udev devices are
enumerated.

[fix-isi-udev PATCH 1/3] udev: do not use post-143 libudev features

Patch 1/3 provides a replacement function for
udev_device_get_property_value(), which is not available in libudev
version 143 required by configure.ac.

[fix-isi-udev PATCH 2/3] udev: refactor add_isi

Patch 2/3 models the add_isi like other add_* functions: it gathers the
information from device nodes and registers the modem when all the
required information is present. Also, it registers the modem only when
a correct phonet device with Ethernet type 820 is found.

[fix-isi-udev PATCH 3/3] ofono.rules: assign isigen driver by USB ids

Patch 3/3 provides a udev rule that detects the isigen driver using the
USB vendor (and product) ids, just like the other modem rules.

--Pekka

--===============1055851982699633517==--

