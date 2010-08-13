Content-Type: multipart/mixed; boundary="===============8906477152969697944=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Query on Ofono Architecture for multiple RATs
Date: Fri, 13 Aug 2010 15:03:10 +0200
Message-ID: <1281704590.23399.10.camel@localhost.localdomain>
In-Reply-To: <AANLkTi=koUsUv-Zdn0D3XrJtgSKzFscV9ejN93k-d1mn@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8906477152969697944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

> Lets suppose that I have a modem which implements various radio access
> technologies like CDMA, WCDMA,  GSM, LTE, etc. The questions I have
> are:
> =

> - How should this modem look like inside Ofono and be exposed outside of =
Ofono?
> - Do you expect to have separate modem drivers for CDMA, WCDMA/GSM and
> LTE or a single driver covering these varied RATs would be accepted?
> - Can there be multiple atoms to support the same functionality in
> various RATs (like SMS or emergency calls) or we can modify one atom
> to support all the RATs?

so what you have is CDMA/EVDO on one side and UMTS/GSM/LTE on the other.
I haven't seen any modem supporting both types at the same time. So
CDMA/EVDO is a separate modem and so is UMTS/GSM/LTE. For these modems
you can RAT selection. For example ISI and also HSO have support for RAT
selection on UMTS/GSM. No LTE since I haven't seen any hardware for it
so far.

> - I guess connman needs to know of the different connections such a
> modem supports and trigger them accordingly? How might this
> functionality look like?

Nope. ConnMan plays pretty much stupid here. Only oFono cares about the
differences.

> - Can the Ofono DBus API differentiate between various RATs based on
> parameters or some new messages needs to be defined if we use a single
> modem driver for multiple RATs?

See my comment above and look at the description of the RAT interface we
already have.

Regards

Marcel



--===============8906477152969697944==--

