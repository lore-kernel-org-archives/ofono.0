Content-Type: multipart/mixed; boundary="===============6629517542166437698=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/2] Tweak at_util_sim_state_query_new() function
Date: Tue, 17 Apr 2012 16:48:22 +0200
Message-ID: <1334674104-30039-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6629517542166437698==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

First patch improves at_util_sim_state_query_new() function.
A user data destroyer can be now specifed.
Second is just updating the plugins that are using this function.

Kind regards,
Guillaume

Guillaume Zajac (2):
  atutil: Add destroyer in at_util_sim_state_query_new prototype
  plugins: Update new at_util_sim_state_query_new() prototype use

 drivers/atmodem/atutil.c |    8 +++++++-
 drivers/atmodem/atutil.h |    3 ++-
 plugins/alcatel.c        |    3 ++-
 plugins/mbm.c            |    2 +-
 plugins/samsung.c        |    3 ++-
 plugins/speedup.c        |    3 ++-
 plugins/zte.c            |    3 ++-
 7 files changed, 18 insertions(+), 7 deletions(-)

-- =

1.7.4.1


--===============6629517542166437698==--

