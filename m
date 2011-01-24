Content-Type: multipart/mixed; boundary="===============3991800076809664770=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: SAT support in oFono
Date: Mon, 24 Jan 2011 11:53:59 +0100
Message-ID: <1295866439.2676.19.camel@aeonflux>
In-Reply-To: <AANLkTim6d_4eHggK7JHO3hjG-uTu-UUbL4cU11VPrtHt@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3991800076809664770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> Let us set aside the the merits of the use cases for these features for
> >> the moment ;)  Implementing Call control by USIM is fairly
> >> straightforward to do in the core.  However, no modem manufacturer
> >> currently allows us to have full control over this feature.  It is
> >> implemented in the firmware and every vendor does this differently.  So
> >> for now support of this feature is in the realm of the modem driver.
> >>
> > okay, so assuming this is how it is going stay. Even modem handles
> > these, ofono should deliver possible AlphaId SIM may give in a response
> > to call control envelope. I did not see if this is implemented. Or is it
> > dropped since it is not tested in GCF..
> =

> I think enabling these types of modems would require the stk driver
> API be able to give a bit of context to a proactive command. For
> example, indicating that a send SMS proactive command is for
> information purposes only, and that the SMS has been sent by the
> modem.

we have this kind of information coming from most modems. Question is
just what to do with it. If the modem already send the SMS for example,
then why bother the host CPU with that kind of information.

You can check ofono_stk_proactive_command_handled_notify() for example
which does this right now.

Regards

Marcel



--===============3991800076809664770==--

