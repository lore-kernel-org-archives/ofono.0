Content-Type: multipart/mixed; boundary="===============8437764321159760703=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 0/5] Call forwarding state handling change
Date: Tue, 31 Jan 2012 11:50:32 +0200
Message-ID: <1328003437-20498-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8437764321159760703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order to correct call forwarding states.

What's missing:
- Only clear the conditional cache flag if a conditional operation is
attempted and succeeds while cfu is active.
- Don't run conditional queries via GetProperties if cfu is active.

Regards,
Oleg

Oleg Zhurakivskyy (5):
  call-forwarding: Minor style fixes
  call-forwarding: Minor refactoring of is_cfu_enabled()
  call-forwarding: Don't set conditional cfs when cfu is active
  call-forwarding: Don't report conditional cfs when cfu is active
  call-forwarding: Emit signals to mask/unmask conditional cfs

 src/call-forwarding.c |  156 ++++++++++++++++++++++++++++++++++-----------=
---
 1 files changed, 110 insertions(+), 46 deletions(-)

-- =

1.7.5.4


--===============8437764321159760703==--

