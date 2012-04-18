Content-Type: multipart/mixed; boundary="===============2041728417740940898=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv3 00/10] mmsd: error management
Date: Wed, 18 Apr 2012 15:27:38 +0200
Message-ID: <1334755668-27458-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2041728417740940898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches concern mmsd and are related to error handling while
receiving message.
The main idea is to try to recover error internally when possible
and drop messages that are not decodable.

Please, ignore previous set of patches sent by Sebastien (when he
reworked my patches) since these are the same except the first
patch (don't always remove message's files, only when the message
is not decodable).


Ronald Tessier (1):
  service: remove files when unable to decode received msg

S=C3=A9bastien Bianti (9):
  service: add debug prints
  service: remove useless variable
  service: add attempts counter variable
  service: move destroy request into process_request
  service: refactoring file closure
  service: callbacks should return a boolean
  service: refactoring error code
  service: add requeue functionality
  service: bearer activity needs to be checked

 src/service.c |  136 ++++++++++++++++++++++++++++++++++++++---------------=
---
 1 files changed, 92 insertions(+), 44 deletions(-)

--
1.7.4.1


--===============2041728417740940898==--

