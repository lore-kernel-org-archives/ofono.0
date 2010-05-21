Content-Type: multipart/mixed; boundary="===============5473936582401279418=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH v1] Read EF_ICCID property of SIM
Date: Fri, 21 May 2010 17:04:19 +0300
Message-ID: <AANLkTinaEwnYg-TKLJLG-CfqeCHeUC6vDTQUdkFJGhy1@mail.gmail.com>
In-Reply-To: <20100520100148.GA18006@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5473936582401279418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/5/20 Daniel Wagner <daniel.wagner@bmw-carit.de>:
> Tested with phonesim.
> + =C2=A0 =C2=A0 =C2=A0 extract_bcd_number(data, length, iccid);

The iccid can be opaque data. It would be safer to extract it as a
real hex number (0-9a-f) and then perhaps strip trailing f's.

-- =

Pekka.Pessi mail at nokia.com

--===============5473936582401279418==--

