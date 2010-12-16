Content-Type: multipart/mixed; boundary="===============9049123859482247678=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: Fix issue in stk null text string handling
Date: Thu, 16 Dec 2010 13:20:15 -0800
Message-ID: <1292534418-13351-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9049123859482247678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

As per the ETSI TS 102 223 specification section 6.5.4,

"If the terminal receives an icon, and either an empty or no alpha
identifier/text string is given by the UICC, than the terminal shall
reject the command with general result "Command data not understood by term=
inal".

In all the other cases, null text string(len=3D0) and empty text string(len=
=3D1)
are valid cases.

Following patch fixes the issue with no text string when icon is also suppl=
ied.

Regards,
Jeevaka

Jeevaka Badrappan (3):
  stkutil: fix issue in null text string
  stk: fix issue with null text string
  unit: remove usage of empty text for null case

 src/stk.c           |   42 ++++++++++++++++++++++++++++++++----------
 src/stkutil.c       |    4 ++--
 unit/test-stkutil.c |    5 +----
 3 files changed, 35 insertions(+), 16 deletions(-)


--===============9049123859482247678==--

