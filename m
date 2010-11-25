Content-Type: multipart/mixed; boundary="===============1413785238087933256=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Thu, 25 Nov 2010 10:23:10 +0200
Message-ID: <20101125082310.GA17294@jh-x301>
In-Reply-To: <201011250940.42941.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1413785238087933256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 25, 2010, R=C3=A9mi Denis-Courmont wrote:
> > > +		boolean Originated [readonly]
> > > +
> > > +			Indicates whether the call was mobile-originated
> > > +			(true) or mobile-terminated (false).
> > > +
> > =

> > What use case are you trying to enable with this API?  I don't see how
> > this could be useful for the UI...
> =

> This becomes a problem if we have more than one application "managing" vo=
ice =

> calls. And I expect that will _be_ the most common case. You have the mai=
n =

> call UI, but you also have the Bluetooth headset/carkit, the USB AT comma=
nds =

> port, and possibly some third party call applications.

Right. At least for HFP the call direction needs to be in the AT+CLCC
reply. I.e. if the bluetoothd ofono telephony driver is used and
bluetoothd starts after one or more calls are already in progress
bluetoothd wouldn't have seen the call setup process and therefore not
know the direction of the call (without this property).

Johan

--===============1413785238087933256==--

