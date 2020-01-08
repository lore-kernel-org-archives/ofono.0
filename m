Content-Type: multipart/mixed; boundary="===============0670139041046772270=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Date: Wed, 08 Jan 2020 14:34:32 -0600
Message-ID: <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
In-Reply-To: <20200107192311.efit6zftt27encdc@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0670139041046772270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

> Do you have a reasonable solution also for second issue?
> =


HSP profile has always been a problem child.  It isn't really all that =

useful as a profile, and given how minimal it is, the right place for it =

always seemed to be inside Pulse Audio itself.  This is what Marcel & I =

agreed upon back about 8-9 years ago anyway.

You are advocating that HSP is still useful, particularly with vendor =

extensions.  Which is fair enough, but now you have to figure out how =

and where to put this support.

As mentioned earlier, one idea you can explore is to create a small =

daemon (or maybe it can even be part of ofonod itself) that will handle =

HSP client/server roles.  See for example the dundee daemon that is part =

of ofono.git.  dundee handles Bluetooth DUN profile and might be a good =

model / starting point for what you're trying to accomplish.

You can then implement the same API interfaces for setting up the HSP =

audio stream as oFono does today (i.e. =

https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/handsfree-a=
udio-api.txt), =

which would make PulseAudio's job much easier, since the audio stream =

aspects would be essentially identical to HFP.  If you're part of =

oFono's tree, then in theory many implementation aspects could be reused.

If you want to provide some higher-level APIs for external applications, =

then HSP specific interfaces (APIs) can be added as needed.

If you decide this is something you want to pursue, then I'm happy to =

host this in the oFono tree.

Regards,
-Denis
--===============0670139041046772270==--

