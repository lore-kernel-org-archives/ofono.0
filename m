Content-Type: multipart/mixed; boundary="===============7741244828522851621=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: problems I have with 1.20
Date: Tue, 09 May 2017 16:36:30 +0200
Message-ID: <6d4441a7-e3d3-6d5f-1372-f64f8e401e0d@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7741244828522851621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've just seen that tag 1.20 has been created.

On my side, this is not the best moment to have a new Ofono version. I =

use a MC7304 modem.

The problems I have with current Ofono version are:

  1) I have to do not set GPRS context ipv4 properties. I made a patch =

for that, not ready to be sent to community.
The goal is to force connman to use DHCP. When connman don't do that, =

MC7304 fails to ping.
This behavior has been seen by libqmi guys and looks like a bug in =

MC7304 firmware:
https://lists.freedesktop.org/archives/libqmi-devel/2016-June/001617.html

I don't know if it affects other Sierra modems.


  2) Ofono crashes when I insert a 4G SIM card in my modem. Problem is =

described in "[PATCH 1/2] gprs: pri_set_apn not exclusively a DBus =

method" mail from Jonas Bonn. I fixed that and will post patch soon.


  3) Even with patch for problem 2, if I have a context coming from =

provisioning, a 4G SIM won't be connected on connman. With current code, =

I will have 2 contexts in this case:

  - one from provisionning

  - one automatically activated created with APN "automatic" (this comes =

from ofono_gprs_cid_activated called from drivers/qmimodem/gprs.c =

(handle_ss_info))

In connman, I only have one service (I don't know why) and I don't =

manage to connect this service (that's quite normal, another context is =

already activated).

I don't know how to fix this case. Its nice to have service directly =

activated without any APN information in LTE case but for same SIM, I =

need to handle 3G case and to provision a context with an APN.

Christophe Ronco


--===============7741244828522851621==--

