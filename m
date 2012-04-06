Content-Type: multipart/mixed; boundary="===============4968912794098293469=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH v1 0/2] Handles errors while receiving messages
Date: Fri, 06 Apr 2012 16:02:45 +0200
Message-ID: <1333720967-17878-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4968912794098293469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

These patches concern mmsd and are related to error handling while
receiving message.
The main idea is to try to recover error internally when possible and
drop messages that are not decodable.


Ronald Tessier (2):
  service: remove files when unable to decode received msg
  service: handle error while receiving messages

 src/service.c |  101 +++++++++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 80 insertions(+), 21 deletions(-)

--
1.7.4.1


--===============4968912794098293469==--

