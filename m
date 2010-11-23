Content-Type: multipart/mixed; boundary="===============7519814778238140430=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RERESEND] [PATCH 2/2] Update the network documentation
Date: Tue, 23 Nov 2010 21:20:00 +0200
Message-ID: <AANLkTimivA3nWN=ROdEFV4aMQVZ4+orwKQY1COO34Pea@mail.gmail.com>
In-Reply-To: <4CEBD781.8080000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7519814778238140430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2010/11/23 Denis Kenzior <denkenz@gmail.com>:
> In fact we were planning to report the current bearer on the
> ConnectionManager interface once we figured out the vendor commands that
> can actually report this information.

Do you mean HSDPA/HSUPA channel allocations, or the tech reported by
CGREG? Because these can differ. For example, a Finnish operator's
cells will not indicate HS*PA support, but HSDPA channel will
nevertheless get allocated when data is moving. This is why for
instance the N900 will show a 3G icon when idle, but switch to 3.5G
when actively receiving data.

Also, we might need to expose CELL_DCH state at some point as well. I
was thinking this could be a property in the RadioSettings interface.

Cheers,
Aki

--===============7519814778238140430==--

