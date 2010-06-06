Content-Type: multipart/mixed; boundary="===============6139065319587030105=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: Test plan for oFono v0.21
Date: Sun, 06 Jun 2010 22:44:49 +0800
Message-ID: <B32E3D5F1713054290B4FF257B89C51A0CAADA4914@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6139065319587030105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Test Objective
--------------------------------------
This is QA regular release testing cycle for oFono released. Our testing fo=
cus would be new features exploration and regression testing, to ensure maj=
or issues for new features are exposed in timely fashion. =


Test Scope
--------------------------------------
The test will do full light functional validation, mainly focus on checking=
 implemented functionality of ofono v0.21 (voice call, message, cell broadc=
ast, phonebook, sim, supplementary service, modem management, voice mail, c=
all volume, call history, message history, GPRS, HFP, USSD) base on phonesi=
m simulator and some hardware devices.

The new feature: =

Modem emulator will do at command testing base ITU v250 spec.
PPP: Had dependence with Modem now but will do it with additional applicati=
on later.
STK is not ready for testing yet.
NITZ is not reay for testing yet

Test Environment
---------------------------------------
General Features:
General PC (pre-installed FC12)
       - ofono v0.21
       - phonesim git tree
HFP:
Netbook EeePC901
      - MeeGo20100601 image
      - Sony Ericsson C903, Nokia N95
      - ofono v0.21
  =

GPRS:
      - MBM modem
      - ofono v0.21
      - UNICOM 3G WCDMA network =


We already start the test and you will get the result at this Wednesday.

B,R
Zhigang

--===============6139065319587030105==--

