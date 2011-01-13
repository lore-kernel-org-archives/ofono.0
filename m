Content-Type: multipart/mixed; boundary="===============4300271567296589885=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/2] Remove unused mpty from ofono_call
Date: Thu, 13 Jan 2011 10:29:55 -0800
Message-ID: <1294943397-27551-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4300271567296589885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Following patch removes the unused internal mpty variable from ofono_call.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  atutil: remove unused mpty
  include: remove unused mpty from ofono_call

 drivers/atmodem/atutil.c |    1 -
 include/types.h          |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)


--===============4300271567296589885==--

