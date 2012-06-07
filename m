Content-Type: multipart/mixed; boundary="===============5874259018119411219=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv5 0/5] Call forwarding state handling change
Date: Thu, 07 Jun 2012 10:21:39 +0300
Message-ID: <1339053704-8749-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5874259018119411219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order to correct call forwarding states.

Changes from v4:

- Check the CFU in order to find whether querying is needed.
- End querying once CFU is active.
- Cache TYPE_ALL queries on supplementary services path.

Regards,
Oleg

Oleg Zhurakivskyy (5):
  call-forwarding: Streamline number assignment
  call-forwarding: Don't query cfs if CFU is active
  call-forwarding: End querying once CFU is active
  call-forwarding: Cache ss TYPE_ALL queries
  TODO: Remove completed call forwarding state task

 TODO                  |   17 -----------------
 src/call-forwarding.c |   14 ++++++++------
 2 files changed, 8 insertions(+), 23 deletions(-)

-- =

1.7.5.4


--===============5874259018119411219==--

