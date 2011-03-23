Content-Type: multipart/mixed; boundary="===============7535023896334061985=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/1] Handle getenv failure case
Date: Wed, 23 Mar 2011 04:42:03 -0700
Message-ID: <1300880524-21559-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7535023896334061985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

If ofono is started before setting the LANG enviroment variable, then
call to getenv fails. This results in the failure of test case
Provide Local Information - Language setting(27.22.4.15 seq 1.5).

Plan is to default to en when the getenv fails. Warning message has
also been added. Distribution will be informed to start ofono after
the locale is set.

Regards,
Jeevaka

Jeevaka Badrappan (1):
  stk: Fix getenv failure case

 src/stk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


--===============7535023896334061985==--

