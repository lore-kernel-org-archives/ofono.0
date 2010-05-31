Content-Type: multipart/mixed; boundary="===============7660797922025984695=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: E63 as generic At Modem?
Date: Mon, 31 May 2010 16:54:02 +0300
Message-ID: <AANLkTilIKHwLy6hCo9l1-szjaageHlMD_MJ-lSxbLEiD@mail.gmail.com>
In-Reply-To: <AANLkTil3WFmjih1wB_Oqbfl-8v1Ndw2LX6xaFCB8U3ap@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7660797922025984695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

2010/5/31 Arun Ravindran <arunlee@gmail.com>:
> Hello All,
>
> I am running the latest ofono in my ubuntu 9.10, under virtual box.
>
> I have connected my E63 through USB and I can see that the isimodem up and
> working.

Good, are you able to make calls with it?

> I tried to use E63 as a generic modem by adding the following to the
> modem.conf

Don't do that. The AT command interface on most Nokia modems is not
very good. Just use the isimodem driver. We don't expect everything to
work flawlessly over USB, but if you experience problems, just 'export
OFONO_ISI_DEBUG=3Dall' and post the debug logs, and we can see if the
problem can be fixed.

However, we are currently using N900 as a reference phone; via USB
while developing and on-device obviously for MeeGo purposes. Other
models may or may not work.

Cheers,
Aki

--===============7660797922025984695==--

