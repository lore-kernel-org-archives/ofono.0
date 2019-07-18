Content-Type: multipart/mixed; boundary="===============5015421442296327983=="
MIME-Version: 1.0
From: Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Detecting if a modem has dialing support
Date: Thu, 18 Jul 2019 15:53:22 +0900
Message-ID: <CAJCx=g==5oo49BDc8DMr4-BE_Bifjsp-NX5T=X1A-SdXPkRdSA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5015421442296327983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello et al,

So there are a few modems that org.ofono.VoiceCallManager interfaces
but don't have Dial support, and there is no programmatic way to check
without dialing attempting to dial a valid phone number.

Can't pass an empty string to test since it would fail the
Error.InvalidFormat test before Error.NotImplemented.  The usecase for
this is we are using several modems per device (including HandsFree)
and want to know in the userspace application which can dial a
respective phone number.

Thanks,

Matt

--===============5015421442296327983==--

