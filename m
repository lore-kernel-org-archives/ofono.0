Content-Type: multipart/mixed; boundary="===============4912541129339267299=="
MIME-Version: 1.0
From: Wei, Jun <jun.wei@intel.com>
Subject: [PATCH v2 0/4] Add support of Neighbor cell info inside ifxmodem
 driver and plugin
Date: Sun, 09 Jan 2011 22:02:56 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B231DCEE42@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1294490366-26454-1-git-send-email-jun.wei@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4912541129339267299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Wei, Jun =

Sent: Saturday, January 08, 2011 8:39 PM
To: ofono(a)ofono.org
Cc: Wei, Jun
Subject: [PATCH v2 0/4] Add support of Neighbor cell info inside ifxmodem d=
river and plugin

From: Jun Wei <jun.wei@intel.com>

Hello,

These are the v2 patches for support of Neighbor cell info inside Infineon =
modem driver and plugin, they are updated as per patches that Antti submit =
on 01/06/2010.

Jun Wei (1):
   Add support of Neighbor Cell Info inside Infineon modem driver and plugin

   drivers/ifxmodem/cell-info.c | 506 +++++++++++++++++++++++++++++++++++++=
+++++
   drivers/ifxmodem/ifxmodem.c  |   2 ++
   drivers/ifxmodem/ifxmodem.h  |   3 +++
   plugin/ifx.c                 |   2 ++
   Makefile.am                  |   3 ++-

Thank you!

--===============4912541129339267299==--

