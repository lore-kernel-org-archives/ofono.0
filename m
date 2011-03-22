Content-Type: multipart/mixed; boundary="===============2497620404266277842=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v2 0/6] Time Independent Escape Sequence implementation
Date: Tue, 22 Mar 2011 10:36:45 +0100
Message-ID: <1300786611-11055-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2497620404266277842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patch will implement the escape sequence detection implementati=
on:
	<pause> +++ <pause>
The <pause> length is fixed by the guard timeouts.
The length to detect +++ sequence is fixed by the escape time.

Guillaume Zajac (6):
  gat: add GAtSuspendFunc CB typedef
  gathdlc: add g_at_hdlc_set_suspend_function() prototype
  gathdlc: add mechansim to detect '+++' escape sequence
  gatppp: add g_at_ppp_set_suspend_function() prototype
  gatppp: add g_at_ppp_set_suspend_function() definition
  emulator: add ppp_suspend() CB and register it

 gatchat/gat.h     |    1 +
 gatchat/gathdlc.c |  111 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/gathdlc.h |    3 +
 gatchat/gatppp.c  |    8 ++++
 gatchat/gatppp.h  |    2 +
 src/emulator.c    |   10 +++++
 6 files changed, 135 insertions(+), 0 deletions(-)


--===============2497620404266277842==--

