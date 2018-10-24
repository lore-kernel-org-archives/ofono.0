Content-Type: multipart/mixed; boundary="===============5589973500865088952=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/1] Re: huawei: network attachment unstability
Date: Wed, 24 Oct 2018 17:09:13 +0200
Message-ID: <1540393754-9419-1-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <CAKSBH7Fm3bLuXX90bCMogNR_DE3OMCZe84D4u8dcNj3XmBHQkQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5589973500865088952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I made a patch that fix the problem I see.
The idea is to force a detach only if:
 - we are attached and powered =3D=3D False
 - we are roaming and RoamingAllowed =3D False

I have tested my use case (loosing network when switching from WCDMA to LTE)
and it is fixed.
I have tested to set RoamingAllowed to false and back to true while roaming.
Detach is forced (AT+CGATT=3D0) when RoamingAllowed is set to false and =

AT+CGATT=3D1 is sent when RoamingAllowed is set back to true.

Christophe Ronco (1):
  gprs: detach from network only if needed

 src/gprs.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- =

2.7.4


--===============5589973500865088952==--

