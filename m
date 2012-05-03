Content-Type: multipart/mixed; boundary="===============2192072735412273666=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 0/4] mmsd: GetConversation support
Date: Thu, 03 May 2012 15:19:59 +0200
Message-ID: <1336051203-15512-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2192072735412273666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches concern mmsd and implement "GetConversation" D-Bus API.

Ronald Tessier (4):
  service: Retrieve get_conversation() args
  service: Fill conversation list with messages
  service: Sort conversation list by message date
  doc: Update service-api.txt

 doc/service-api.txt |    6 ++
 src/service.c       |  141 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 147 insertions(+), 0 deletions(-)

--
1.7.4.1


--===============2192072735412273666==--

