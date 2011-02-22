Content-Type: multipart/mixed; boundary="===============7376926535951517641=="
MIME-Version: 1.0
From: Rolf Offermanns <roffermanns@sysgo.com>
Subject: Supported USB modems?
Date: Tue, 22 Feb 2011 12:22:56 +0100
Message-ID: <4D639C90.60108@sysgo.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7376926535951517641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I am trying to get ofono to work with several usb modems from Vodofone
(ZTE and Huawei inside) and so far not a single one works.

I don't have the time to fix this myself, but I can provide logs, do
tests, etc. if there is somebody who is interested in fixing this.

Which devices do you use for testing?

List of my devices:
Huawei E172 [12d1:1003] (connector loose, don't know how long it will work)
Huawei K3715 [12d1:1001]
ZTE K4505-Z [19d2:2000]
ZTE K3765-Z [19d2:2002]

The only modem that actually shows up in the list-modems output is the
Huawei K3715. But "online-modem" fails.

I am on current git.

If anyone can help and spare some time, please tell me what you need
from me.
If you need logs, is "OFONO_AT_DEBUG=3D1 ./src/ofonod -d '*' -n" OK and
shall I sent them to this list (will be a long mail)?

Thanks,
Rolf
-- =

Rolf Offermanns <roffermanns@sysgo.com>
SYSGO AG     Tel.: +49-6136-9948-0
Am Pfaffenstein 14   Fax: +49-6136-9948-10
55270 Klein-Winternheim  http://www.sysgo.com

Handelsregister: HRB Mainz 90 HRB 8066
Vorstand: Michael Tiedemann
Aufsichtsratsvorsitzender: Juergen Bullacher
USt(VAT)-Id-Nr.: DE 149062328

--===============7376926535951517641==--

