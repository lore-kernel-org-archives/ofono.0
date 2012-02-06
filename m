Content-Type: multipart/mixed; boundary="===============8512939422451128040=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv2 0/8] Call forwarding state handling change
Date: Mon, 06 Feb 2012 14:33:53 +0200
Message-ID: <1328531641-10612-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8512939422451128040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order to correct call forwarding states.

Changes from v2:

- Don't run conditional queries if cfu is active.
- Clear the conditional cache flag on conditional deactivation
  while cfu is active.

Regards,
Oleg

Oleg Zhurakivskyy (8):
  call-forwarding: Minor style fixes
  call-forwarding: Minor refactoring of is_cfu_enabled()
  call-forwarding: Don't set conditional cfs when cfu is active
  call-forwarding: Don't report conditional cfs when cfu is active
  call-forwarding: Emit signals to mask/unmask conditional cfs
  call-forwarding: Don't run conditional queries if cfu is active
  call-forwarding: Clear the conditional cache flag
  TODO: Remove completed call forwarding state task

 TODO                  |   17 -----
 src/call-forwarding.c |  182 ++++++++++++++++++++++++++++++++++-----------=
---
 2 files changed, 129 insertions(+), 70 deletions(-)

-- =

1.7.5.4


--===============8512939422451128040==--

