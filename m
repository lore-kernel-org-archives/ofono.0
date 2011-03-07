Content-Type: multipart/mixed; boundary="===============0863532127878379693=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/2] Fix issue with null data object
Date: Mon, 07 Mar 2011 07:35:48 -0800
Message-ID: <1299512150-19314-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0863532127878379693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

As per the specification, if the alpha identifier is provided by the UICC
and is a null data object (i.e. length =3D '00' and no value part), this is=
 an
indication that the terminal should not give any information to the user.

Regards,
Jeevaka

Jeevaka Badrappan (2):
  stk: fix issue with null data object
  stkutil: fix issue with null data object

 src/stk.c     |    2 +-
 src/stkutil.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


--===============0863532127878379693==--

