Content-Type: multipart/mixed; boundary="===============0655935785540670873=="
MIME-Version: 1.0
From: Forest Bond <forest@alittletooquiet.net>
Subject: [RFC PATCH 0/3] Fix CDMA support with composite plugins
Date: Thu, 28 Mar 2013 10:21:12 -0400
Message-ID: <20130328142112.GF29445@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0655935785540670873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Support for Huawei CDMA devices has been broken since the huaweicdma
plugin was merged into the huawei plugin.  The root cause for the
breakage is that:

1. CDMA devices rely on being automatically set to online state once
   enabled.  This is because they do not expose a SIM interface, so
   clients (e.g. ConnMan) don't have a good way to know that a device is
   ready to be set online.

2. The modem is only automatically set online if the modem driver does
   not define a set_online callback.  But since the huawei plugin
   supports both GSM and CDMA devices, it must provide a set_online
   callback.  So oFono core does not automatically set Huawei CDMA
   modems online when enabled.

On IRC Denis suggested solving this problem by splitting CDMA support
from the huawei plugin so that we can again have a huaweicdma driver
with no set_online callback.  I looked into this and of course it is
possible.  But to me it feels like a big step backward for the huawei
driver.

The split plugin approach also complicates handling of Sierra Wireless
CDMA devices (which I'm working on).  It forces us to maintain a
database of USB IDs mapped to the right driver to use.  But if we use a
single driver we can detect CDMA support when the device is enabled like
the huawei driver does.

As Denis said, CDMA support in oFono is a hack because oFono is
SIM-centric.  Right now clients have to jump through a different set of
hoops to get a CDMA device online than they do for a GSM device.  So the
root cause of the CDMA problem is that the D-BUS API exposed for CDMA
devices is crippled, which creates the need to automatically set CDMA
devices online.  The long term fix for this problem is to either further
abstract the D-Bus API from the device or make CDMA devices look more
like GSM devices.

But in the meantime what we really want is a way to tell the core to
automatically set a device online even if the modem driver provides a
set_online callback.  So I propose the following patch series as a
simple way to do this.

Thanks,
Forest

Forest Bond (3):
  modem: Allow setting boolean properties
  modem: Support modem property "AlwaysOnline"
  huawei: Set property "AlwaysOnline" for CDMA modems

 plugins/huawei.c |    3 +++
 src/modem.c      |   18 +++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

--===============0655935785540670873==--

