Content-Type: multipart/mixed; boundary="===============5014436273821994125=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Sim plug-and-play
Date: Wed, 05 Sep 2012 07:51:05 -0500
Message-ID: <50474AB9.5080609@gmail.com>
In-Reply-To: <loom.20120905T133456-510@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5014436273821994125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cornel,

On 09/05/2012 06:38 AM, Cornel Spinu wrote:
> Hi,
>
> I'm using ofono 0.48 with a cinterion modem and I want enable an plug-and=
-play

That version is over a year old, I strongly suggest using something much =

more recent.

> sim. Basically when I insert a sim into the modem, I want to do an pin ch=
eck and
> then continue with other procedures. I was think of creating a notify fun=
ction
> when AT^SCKS function returns 1 (sim inserted). The thing is I dont know =
where

I'm not really sure what you're asking, you'll have to provide more =

details.  What does AT^SCKS do? Is that an unsolicited notification or =

something you have to poll?

> to capture the response from that command. Can anyone give me a suggetion?
>

You can see an example of how SIM hot-swap is implemented in e.g. =

plugins/ifx.c.  Just grep for XSIM.

Regards,
-Denis

--===============5014436273821994125==--

