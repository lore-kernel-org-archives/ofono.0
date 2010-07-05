Content-Type: multipart/mixed; boundary="===============9128604964957194785=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 0/6] Add oFono DUN emulator
Date: Mon, 05 Jul 2010 13:45:03 +0800
Message-ID: <1278308709-13908-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9128604964957194785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series are the initial patches for ofono DUN emulator.

1. src/emulator.c handles emulator create, remove, enable, disable and etc..
2. plugins/dun_gw.c is the plugin similar to hfp.c. It's the interface with=
 BlueZ serial DUN agent.
3. gatchat/test-emulator.c is the test case to test emulator without BlueZ =
interface.

Emulator driver is registered statically once ofonod starts up. It probes B=
lueZ adapter properties to create emulator on active modem that having GPRS=
 interface.

Thanks,
Zhenhua


--===============9128604964957194785==--

