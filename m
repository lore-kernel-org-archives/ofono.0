Content-Type: multipart/mixed; boundary="===============1030756591724943903=="
MIME-Version: 1.0
From: Faiyaz Baxamusa <faiyaz.baxamusa@nokia.com>
Subject: [PATCH 0/3] Make Message state feature independent of the stack
Date: Thu, 06 Jan 2011 11:50:52 -0800
Message-ID: <1294343455-29551-1-git-send-email-faiyaz.baxamusa@nokia.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1030756591724943903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set of patches enable the "org.ofono.Message" interface code to be
independent of the protocol stack. This will enable both GSM and CDMA SMS s=
tack
to reuse the interface code.

The changes have been tested with phonesim using send-sms script.

Faiyaz Baxamusa (3):
  doc: Add message state API
  include: Introduce message
  message: Code independent of protocol stack

 Makefile.am               |    6 +-
 doc/cdma-message-api.txt  |    5 +
 doc/message-api.txt       |   24 +----
 doc/message-state-api.txt |   27 +++++
 include/message.h         |   67 ++++++++++++
 src/message.c             |  257 +++++++++++++++++++++++++++++++++++++++++=
+++
 src/ofono.h               |    2 +
 src/sms.c                 |  258 +++++++----------------------------------=
----
 8 files changed, 399 insertions(+), 247 deletions(-)
 create mode 100644 doc/message-state-api.txt
 create mode 100644 include/message.h
 create mode 100644 src/message.c


--===============1030756591724943903==--

