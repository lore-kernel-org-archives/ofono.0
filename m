Content-Type: multipart/mixed; boundary="===============6373361913372186743=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 00/13] Call forwarding state handling change
Date: Tue, 10 Apr 2012 15:17:21 +0300
Message-ID: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6373361913372186743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order to correct call forwarding states.

Changes from v3:

- Re-run conditional queries on cfu removal and mark cached.
- End querying once cfu is active.
- Handle the caching on supplementary services path
  cfs modifications.

Regards,
Oleg

Oleg Zhurakivskyy (13):
  call-forwarding: Refactor cf_condition_compare()
  call-forwarding: Refactor cf_condition_find_with_cls()
  call-forwarding: Get rid of extra variable
  call-forwarding: Streamline number assignment
  call-forwarding: Streamline cf_find_timeout() logic
  call-forwarding: Refactor cf_find_unconditional()
  call-forwarding: Streamline set_query_cf_callback()
  call-forwarding: Remove unneeded variable
  call-forwarding: End querying once cfu is active
  call-forwarding: CFU unset, update conditionals
  call-forwarding: Re-run ss path queries on CFU unset
  call-forwarding: Cache ss TYPE_ALL modifications
  TODO: Remove completed call forwarding state task

 TODO                  |   17 -----
 src/call-forwarding.c |  168 ++++++++++++++++++++-------------------------=
----
 2 files changed, 68 insertions(+), 117 deletions(-)

-- =

1.7.5.4


--===============6373361913372186743==--

