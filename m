Content-Type: multipart/mixed; boundary="===============6660155971110104601=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: MNC/MCC as string?
Date: Wed, 10 Jun 2009 19:42:02 +0300
Message-ID: <200906101942.02477.remi@remlab.net>
In-Reply-To: <200906101115.20159.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6660155971110104601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le mercredi 10 juin 2009 19:15:19 Denis Kenzior, vous avez =C3=A9crit :
> > Nokia modems both send and receive MNC/MCC pairs as Binary Coded Decimal
> > (BCD) strings. Any 2 digit MNC is padded with 0xF. Problem is, when
> > listing operators, the conversion of MNC codes from BCD to short loses
> > this information, and will result in manual network selection failing
> > (BCD '001' -> short '1' -> BCD '01F' !=3D BCD '001').
> >
> > Anyone opposed to changing the mnc and mcc code types from short to
> > string?
>
> I agree that this does seem to be an issue, so no problems in changing
> this. Do you consider this an implementation issue only (e.g. APIs do not
> change) or do you want to change the NetworkOperator attributes to a stri=
ng
> as well?  If this is an implementation issue we can always adopt the Nokia
> convention of padding the MNC by 0xF on the right and leave them as a
> 'short'.

Well, the point is that leading zeroes are meaningful (much like with phone =

numbers in fact). The API, not just the implementation, must distinguish =

network "xy" from network "0xy", so that manual selection remains unambiguo=
us. =

A D-Bus string is probably nicer to use than an integer using ISI's BCD =

scheme.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D


--===============6660155971110104601==--

