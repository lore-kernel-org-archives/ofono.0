Content-Type: multipart/mixed; boundary="===============8244547440113411023=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/1] Add null text string case to phonesim
Date: Mon, 03 Jan 2011 01:43:09 -0800
Message-ID: <1294047790-2465-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8244547440113411023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

 Null text string object is text string with len =3D 0 whereas empty text
string is text string with len =3D 1 but no value for text string. =

Handling procedure remains the same for both cases. Following patch
adds the null text string case as well to the phonesim.

Regards,
Jeevaka
 =

Jeevaka Badrappan (1):
  phonesim: add null text string case

 src/qsimcommand.cpp |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)


--===============8244547440113411023==--

