Content-Type: multipart/mixed; boundary="===============9179827421527951773=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCHv2] network: query signal strength
Date: Wed, 05 Jan 2011 11:08:12 +0200
Message-ID: <AANLkTikxRG7QNtbDbDyofL-ouC1J8eq9=av=W2+O7516@mail.gmail.com>
In-Reply-To: <1292579164-24372-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9179827421527951773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

2010/12/17 Marit Henriksen <maritsofie.henriksen8@gmail.com>:
> From: Marit Henriksen <marit.henriksen@stericsson.com>
>
> Signal strength is set to -1 whenever registration status changes
> and differs from registered or roaming. When registration status
> changes again to registered or roaming, the signal strength needs to
> be updated, added query towards driver to get it.

Typically the modem updates signal strength along with registration
status.  What are you trying to achieve here?  Is this to avoid
problems caused by reordering, i.e., ofono_netreg_strength_notify()
getting called before ofono_netreg_status_notify()?

<snip>

> @@ -1319,6 +1332,9 @@ void ofono_netreg_status_notify(struct ofono_netreg=
 *netreg, int status,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (netreg->driver=
->current_operator)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0netreg->driver->current_operator(netreg,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0current_o=
perator_callback, netreg);

Add extra line feed here.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (netreg->driver->st=
rength)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 netreg->driver->strength(netreg,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 signal_stren=
gth_callback, netreg);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_error=
 error;
>

Cheers,
Aki

--===============9179827421527951773==--

