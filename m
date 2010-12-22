Content-Type: multipart/mixed; boundary="===============0454685484485716258=="
MIME-Version: 1.0
From: antti.paila@nokia.com
Subject: RE: [RFC PATCH 2/4] cell-info: Header file for cell-info atom
Date: Wed, 22 Dec 2010 07:41:37 +0000
Message-ID: <4FC3F10CC1AA4D4C997A651B961B375C0769DDEC@008-AM1MPN1-026.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0454685484485716258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


> Shouldn't ofono_cell_info_results be defined here and included as an
> argument for
> ofono_cell_info_query_cb_t ?

Indeed that would make more sense. Now the ofono_cell_info_results is insid=
e the ofono_cell_info, but of course if there are multiple requests sent to=
 a modem the latter one will overwrite the former one.

-Antti

--===============0454685484485716258==--

