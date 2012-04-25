Content-Type: multipart/mixed; boundary="===============0539498792312086015=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv1 0/5] mmsd: GetConversation support
Date: Wed, 25 Apr 2012 11:01:48 +0200
Message-ID: <1335344513-2347-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0539498792312086015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches concern mmsd and implement "GetConversation" D-Bus API.

Ronald Tessier (5):
  service: Add GetConversation method
  service: Retrieve get_conversation() args
  service: Fill conversation list with messages
  service: Sort conversation list by message date
  doc: Update service-api.txt

 doc/service-api.txt |    9 +++-
 src/service.c       |  171 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 179 insertions(+), 1 deletions(-)

--
1.7.4.1


--===============0539498792312086015==--

