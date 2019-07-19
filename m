Content-Type: multipart/mixed; boundary="===============8922826041617595525=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Detecting if a modem has dialing support
Date: Thu, 18 Jul 2019 23:43:23 -0500
Message-ID: <7e3ce17e-adbd-f326-43f2-59b19417da87@gmail.com>
In-Reply-To: <CAJCx=g==5oo49BDc8DMr4-BE_Bifjsp-NX5T=X1A-SdXPkRdSA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8922826041617595525==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On 7/18/19 1:53 AM, Matt Ranostay wrote:
> Hello et al,
> =

> So there are a few modems that org.ofono.VoiceCallManager interfaces
> but don't have Dial support, and there is no programmatic way to check
> without dialing attempting to dial a valid phone number.
> =


If a modem driver creates a voicecall atom (thus exposing =

VoiceCallManager) without actually checking that voice dialing is =

supported, then that is a bug in the individual modem driver.  That =

should really be fixed first..

> Can't pass an empty string to test since it would fail the
> Error.InvalidFormat test before Error.NotImplemented.  The usecase for
> this is we are using several modems per device (including HandsFree)
> and want to know in the userspace application which can dial a
> respective phone number.

I think this is a lost cause as the error returned will vary by modem =

firmware.

Regards,
-Denis

--===============8922826041617595525==--

