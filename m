Content-Type: multipart/mixed; boundary="===============4026112090557471903=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/3] Add null text/alpha identifier and icon check handling
Date: Fri, 31 Dec 2010 14:30:44 +0200
Message-ID: <1293798647-4256-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4026112090557471903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Following patch adds the missing "text/alpha identifier and icon" check
handling.

As per the ETSI 102 223 section 6.8, Text string is only required in respon=
se
to a GetInkey or GetInput proactive command. So, there is no need to add any
specific handling for null or empty strings cases.

As per the ETSI TS 102 223 section 6.5.4, "If the terminal receives an =

icon, and either an empty or no alpha identifier/text string is given
by the UICC, than the terminal shall reject the command with general"
result "Command data not understood by terminal"."

Regards,
Jeevaka

Jeevaka Badrappan (3):
  stkutil: Allocate for empty string in text dataobj
  stkutil: add missing text and icon check
  unit: add error status support for failure cases

 src/stkutil.c       |  189 ++++++++++++++++++++++++++++++++++++++++++++++-=
----
 unit/test-stkutil.c |   12 ++-
 2 files changed, 180 insertions(+), 21 deletions(-)


--===============4026112090557471903==--

