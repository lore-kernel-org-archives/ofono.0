Content-Type: multipart/mixed; boundary="===============2993920281999509724=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] gatchat: add a GARBAGE state to handle random crud
 from a terminal adapter
Date: Thu, 06 Aug 2009 17:06:41 -0500
Message-ID: <200908061706.41763.denkenz@gmail.com>
In-Reply-To: <20090805175131.2054657b@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2993920281999509724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> I've got a version of this that works w/ denkenz's new parser stuff;
> let me know if I should send that instead.
>
>
>
> From d6e942c2e0e2f51c5391e61aa7b5ac7326de28ea Mon Sep 17 00:00:00 2001
> From: Andres Salomon <dilinger@collabora.co.uk>
> Date: Tue, 4 Aug 2009 21:33:09 -0400
> Subject: [PATCH 2/2] gatchat: add a GARBAGE state to handle random crud
> from a terminal adapter
>
> When the TA sends random crap, oFono's parser gets confused and doesn't
> process the next few results (which causes oFono not to send further
> commands, and thus initialization never finishes).  This is less than
> ideal.
>
> This patch adds a new state; when the parser gets something that doesn't
> look like a proper response, it will simply ignore the entire line.  This
> allows initialization to continue when the TA does send spurious lines.

I've incorporated a modified version of this into the new default gsmv1 par=
ser =

as part of the customizable parser patch.  This is now upstream, and I'd li=
ke =

to hear about how well it works.

Regards,
-Denis




--===============2993920281999509724==--

