Content-Type: multipart/mixed; boundary="===============7289386211977807474=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/7] sms: Cancel pending message
Date: Fri, 04 Feb 2011 13:02:37 -0200
Message-ID: <1296831764-6554-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7289386211977807474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch set exports on MessageManager interface a method to cancel messa=
ges
that are pending on tx queue.

As the doc says, only messages that are currently waiting on message queue =
and
not being handled by the modem can be cancelled. Otherwise a race could occ=
ur.

First 4 patches are some refactors needed to accommodate this feature, that=
 has
been added on 5th patch.

Lucas De Marchi (7):
  history: add cancelled status
  examples: handle cancelled history status
  message: add cancelled state
  sms: factor out 'remove entry' from tx_finished()
  sms: allow message submission to be cancelled
  doc: add CancelMessage to MessageManager
  TODO: mark task 'cancel pending SMS' as done

 TODO                       |    9 --
 doc/messagemanager-api.txt |   10 +++
 examples/history.c         |    5 +
 include/history.h          |    1 +
 src/message.c              |    2 +
 src/message.h              |    3 +-
 src/sms.c                  |  181 ++++++++++++++++++++++++++++++++++------=
----
 7 files changed, 161 insertions(+), 50 deletions(-)

-- =

1.7.4


--===============7289386211977807474==--

