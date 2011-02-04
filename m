Content-Type: multipart/mixed; boundary="===============4720377670969823784=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 0/8] sms: Cancel pending message
Date: Fri, 04 Feb 2011 17:40:30 -0200
Message-ID: <1296848438-5584-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4720377670969823784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In this version I fixed some issues pointed out by Andrzej and added another
patch, not so related, but that would conflict with these ones if applied to
current master branch. Difference from previous version:

Tested with phonesim, slightly changing its plugin in oFono in order to hold
messages for a certain period.

Lucas De Marchi (8):
  history: add cancelled status
  examples: handle cancelled history status
  message: add cancelled state
  sms: factor out 'remove entry' from tx_finished()
  sms: allow message submission to be cancelled
  doc: add CancelMessage to MessageManager
  TODO: mark task 'cancel pending SMS' as done
  sms: remove check for impossible NULL condition

 TODO                       |    9 --
 doc/messagemanager-api.txt |   12 +++
 examples/history.c         |    5 +
 include/history.h          |    1 +
 src/message.c              |    2 +
 src/message.h              |    3 +-
 src/sms.c                  |  196 +++++++++++++++++++++++++++++++++-------=
---
 7 files changed, 172 insertions(+), 56 deletions(-)

-- =

1.7.4


--===============4720377670969823784==--

