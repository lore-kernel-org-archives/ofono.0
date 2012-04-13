Content-Type: multipart/mixed; boundary="===============4041940091590581523=="
MIME-Version: 1.0
From: =?unknown-8bit?q?S=C3=A9bastien?= Bianti <sebastien.bianti@linux.intel.com>
Subject: [PATCH v2 00/10] mmsd: error management
Date: Fri, 13 Apr 2012 18:33:39 +0200
Message-ID: <1334334829-31617-1-git-send-email-sebastien.bianti@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4041940091590581523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series concerns mmsd for ofono mailing list.

This is essentially a rework of Ronald's patches.

Was:
> Hi,

> These patches concern mmsd and are related to error handling while
> receiving message.
> The main idea is to try to recover error internally when possible and
> drop messages that are not decodable.


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

 src/service.c |  134 ++++++++++++++++++++++++++++++++++++++---------------=
----
 1 files changed, 90 insertions(+), 44 deletions(-)

-- =

1.7.4.4


--===============4041940091590581523==--

