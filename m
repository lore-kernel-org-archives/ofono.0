Content-Type: multipart/mixed; boundary="===============8520355292071190767=="
MIME-Version: 1.0
From: Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: Detecting if a modem has dialing support
Date: Fri, 19 Jul 2019 18:45:13 +0900
Message-ID: <CAJCx=gmZ8Fg07HAbfFxE+SgO52-pyTLZvG=_ZznSM6sTRDSu6w@mail.gmail.com>
In-Reply-To: <7e3ce17e-adbd-f326-43f2-59b19417da87@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8520355292071190767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 1:43 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Matt,
>
> On 7/18/19 1:53 AM, Matt Ranostay wrote:
> > Hello et al,
> >
> > So there are a few modems that org.ofono.VoiceCallManager interfaces
> > but don't have Dial support, and there is no programmatic way to check
> > without dialing attempting to dial a valid phone number.
> >
>
> If a modem driver creates a voicecall atom (thus exposing
> VoiceCallManager) without actually checking that voice dialing is
> supported, then that is a bug in the individual modem driver.  That
> should really be fixed first..

It is in the qmimodem driver, and not sure if any modem using that
driver is implementing
dialing support.

 - Matt

>
> > Can't pass an empty string to test since it would fail the
> > Error.InvalidFormat test before Error.NotImplemented.  The usecase for
> > this is we are using several modems per device (including HandsFree)
> > and want to know in the userspace application which can dial a
> > respective phone number.
>
> I think this is a lost cause as the error returned will vary by modem
> firmware.
>
> Regards,
> -Denis

--===============8520355292071190767==--

