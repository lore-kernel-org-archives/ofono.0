Content-Type: multipart/mixed; boundary="===============0202840438996950551=="
MIME-Version: 1.0
From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Date: Thu, 09 Jan 2020 07:42:56 +0200
Message-ID: <3d61da57f8fd37a3ac6d5991326497c2f9896d23.camel@iki.fi>
In-Reply-To: <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0202840438996950551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, I'd like to point out that Pali's messages aren't getting through
to the ofono mailing list. Is he not subscribed?

-- Tanu


On Wed, 2020-01-08 at 14:34 -0600, Denis Kenzior wrote:
> Hi Pali,
> =

> > Do you have a reasonable solution also for second issue?
> > =

> =

> HSP profile has always been a problem child.  It isn't really all that =

> useful as a profile, and given how minimal it is, the right place for it =

> always seemed to be inside Pulse Audio itself.  This is what Marcel & I =

> agreed upon back about 8-9 years ago anyway.
> =

> You are advocating that HSP is still useful, particularly with vendor =

> extensions.  Which is fair enough, but now you have to figure out how =

> and where to put this support.
> =

> As mentioned earlier, one idea you can explore is to create a small =

> daemon (or maybe it can even be part of ofonod itself) that will handle =

> HSP client/server roles.  See for example the dundee daemon that is part =

> of ofono.git.  dundee handles Bluetooth DUN profile and might be a good =

> model / starting point for what you're trying to accomplish.
> =

> You can then implement the same API interfaces for setting up the HSP =

> audio stream as oFono does today (i.e. =

> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/handsfree=
-audio-api.txt), =

> which would make PulseAudio's job much easier, since the audio stream =

> aspects would be essentially identical to HFP.  If you're part of =

> oFono's tree, then in theory many implementation aspects could be reused.
> =

> If you want to provide some higher-level APIs for external applications, =

> then HSP specific interfaces (APIs) can be added as needed.
> =

> If you decide this is something you want to pursue, then I'm happy to =

> host this in the oFono tree.
> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org

--===============0202840438996950551==--

