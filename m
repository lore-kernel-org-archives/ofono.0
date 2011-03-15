Content-Type: multipart/mixed; boundary="===============5755310317879830827=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/6] PPP suspend mechanism implementation
Date: Tue, 15 Mar 2011 10:18:57 +0100
Message-ID: <1300180743-27624-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5755310317879830827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patch will make hdlc layer detecting "+...+...+" character to s=
uspend PPP server and resume AT server:

either for receiving ATH (implemented in one other future patch)
either for receiving ATO (implemented in a future 2nd set of patch)

Guillaume Zajac (6):
  gat: add GAtSuspendFunc CB typedef
  gathdlc: add prototype to set suspend function.
  gathdlc: add mechanism to detect ppp suspension from DUN client.
  gatppp: add prototype to set ppp suspend function.
  gatppp: add g_at_ppp_set_suspend_function() definition.
  emulator: add ppp_suspend implementation and registration.

 gatchat/gat.h     |    1 +
 gatchat/gathdlc.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/gathdlc.h |    3 ++
 gatchat/gatppp.c  |    8 +++++++
 gatchat/gatppp.h  |    2 +
 src/emulator.c    |   10 +++++++++
 6 files changed, 82 insertions(+), 0 deletions(-)


--===============5755310317879830827==--

