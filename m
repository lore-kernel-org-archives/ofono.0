Content-Type: multipart/mixed; boundary="===============2852967452773997379=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [ofono] vendor code
Date: Wed, 01 Dec 2010 19:52:06 +0200
Message-ID: <AANLkTikSUHqoMmuFjojAoFhvbKbZxf-Uw4omLV83REpD@mail.gmail.com>
In-Reply-To: <AANLkTimd=Q+4pwJAuBMtePYGOg6dCPU13THrp1_yA+EX@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2852967452773997379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tonny,

> Any possibility that this is a race condition? =C2=A0Just while ofono
> sending AT+CGREG? to poll the CGREG state, modem already sent out
> unsolicited CGREG? =C2=A0I saw at_util_parse_reg() also tries to skip
> unsolicited CREG/CGREG, so it looks like this is valid concern?

This definitely looks like glare to me, the modem sends unsolicited
response and then response to AT+CGREG?, and at_util_parse_reg() gets
very confused.

--Pekka

--
Pekka.Pessi mail at nokia.com

--===============2852967452773997379==--

