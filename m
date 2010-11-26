Content-Type: multipart/mixed; boundary="===============6787421363149288883=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Fri, 26 Nov 2010 10:21:08 +0200
Message-ID: <20101126082108.GA6043@jh-x301>
In-Reply-To: <4CEEF676.3020902@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6787421363149288883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Nov 25, 2010, Denis Kenzior wrote:
> > Right. At least for HFP the call direction needs to be in the AT+CLCC
> > reply. I.e. if the bluetoothd ofono telephony driver is used and
> > bluetoothd starts after one or more calls are already in progress
> > bluetoothd wouldn't have seen the call setup process and therefore not
> > know the direction of the call (without this property).
> =

> I really don't view +CLCC emulation outside oFono as a valid use case.
> We already have a task to implement HFP AG role inside oFono, and
> especially with CDMA on the horizon this is the only way to go.
> =

> So unless there are more convincing arguments, I'm against this API
> change.  I really suggest that instead of doing this outside oFono,
> someone picks up the AT modem emulator work and continue where Zhenhua
> left off.

Picking up the AT modem emulator work is definitely something that
should happen. I also want to see that. However, wanting to accelarate
that work forward is imho the wrong reason reject this API. The BlueZ
ofono telephony driver is something that exists over a year now and
it'll continue to be partially broken wrt. +CLCC as long as there's a
requirement to "see" the call state changes in order to know the call
direction. Just yesterday we merged an optimization which initializes
the driver only when Bluetooth gets powered on and this further
increases the likelyhood of an ongoing call when the initialization
happens.

Another argument in favor of this API is that without it the D-Bus API
is in a way incomplete. You have a piece of state information that's
available by observing the state changes but not for a entity that jumps
into the game after the changes have happened. It's a bit like having an
API with a StateChanged signal but without a GetState method.

Johan

--===============6787421363149288883==--

