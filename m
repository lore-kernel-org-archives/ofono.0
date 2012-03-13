Content-Type: multipart/mixed; boundary="===============4663911559132190325=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 00/12] Call forwarding state handling change
Date: Tue, 13 Mar 2012 15:46:21 +0200
Message-ID: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4663911559132190325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order to correct call forwarding states.

Changes from v2:

- Re-run conditional queries on cfu removal and mark cached.
- Handle the caching properly on supplementary services path
  unconditional/all/all conditional cfs modifications.

Regards,
Oleg

Oleg Zhurakivskyy (12):
  call-forwarding: Remove cf_list_clear()
  call-forwarding: Inline get_query_next_cf_cond()
  call-forwarding: Refactor cf_condition_find_with_cls() slightly
  call-forwarding: Refactor cf_find_unconditional()
  call-forwarding: Minor cleanup of set_query_cf_callback
  call-forwarding: Don't run conditional queries if cfu is active
  call-forwarding: Re-run conditional queries on cfu removal
  call-forwarding: Toggle the cached flag on CFU changes
  call-forwarding: Cache cfs on CFU removal
  call-forwarding: Re-run ss path cfs queries on cfu changes
  call-forwarding: Cache cfs on all/all conditional removal
  TODO: Remove completed call forwarding state task

 TODO                  |   17 ----
 src/call-forwarding.c |  237 +++++++++++++++++++++------------------------=
----
 2 files changed, 100 insertions(+), 154 deletions(-)

-- =

1.7.5.4


--===============4663911559132190325==--

