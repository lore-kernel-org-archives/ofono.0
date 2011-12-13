Content-Type: multipart/mixed; boundary="===============2480796743952202361=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 0/3] CPHS SPN, short-SPN support
Date: Tue, 13 Dec 2011 13:36:21 +0200
Message-ID: <1323776184-27086-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2480796743952202361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the reworked version of the CPHS SPN and short-SPN TODO items.

Changes from v1:

- Removed some in place code to emit the operator display name,
  netreg_emit_operator_display_name() is used everywhere.
- Taking advantage of the CPHS Information Service Table.
  CPHS 4.2 specifies active / allocated bits for SPN short only.
  So, if CPHS SPN short bits are on, the logic is to check
  first for CPHS SPN with a fallback to CPHS SPN short.
- Separate callbacks for SPN variants in order to make the logic simpler.
- Refresh cases for CPHS SPN variants are taken into account.

What's missing:

- changes to the SPN callback in src/grps.c in order not to duplicate the l=
ogic for SPN, CPHS SPN and short SPN in both files.

Regards,
Oleg

Oleg Zhurakivskyy (3):
  network: Use netreg_emit_operator_display_name()
  network: Add CPHS SPN, short-SPN fallbacks
  TODO: Remove completed CPHS SPN and short-SPN tasks

 TODO          |   14 ---
 src/network.c |  254 ++++++++++++++++++++++++++++++++++++++---------------=
----
 2 files changed, 170 insertions(+), 98 deletions(-)

-- =

1.7.5.4


--===============2480796743952202361==--

