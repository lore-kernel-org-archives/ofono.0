Content-Type: multipart/mixed; boundary="===============6344327748727043466=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Plugin infrastructure
Date: Mon, 05 Feb 2018 10:19:01 -0600
Message-ID: <d13d203d-404a-bd2a-6962-ef973a1b949e@gmail.com>
In-Reply-To: <0238d65e-d24f-06af-7e56-bc33da8b22d6@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6344327748727043466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 02/04/2018 11:19 AM, Jonas Bonn wrote:
> Hi,
> =

> I was reading through the ofono code and I see that there's a lot of =

> code in place to support external plugins.=C2=A0 As things currently stan=
d, =

> however, ofono can only be built with _builtin_ modules, so all this =

> plugin infrastructure is totally unused.=C2=A0 So I had a couple of quest=
ions =

> about this:
>
> i)=C2=A0 Is there any value in keeping the plugin infrastructure in place=
? =

> ...or would an effort to remove it be valued?

We did (still do?) have external plugins in use...

> =

> ii)=C2=A0 Does anyone actually use the include/exclude module patterns to =

> prevent "plugins" (modules) from being automatically loaded?

yes...

> =

> I could imagine marking all module init/exit functions with GCC =

> attributes "constructor/destructor" and have them automatically and =

> unconditionally initialized at startup.=C2=A0 This would, however, render=
 the =

> exclude pattern option useless...
> =

> iii) Of course, using GCC attributes ties the project closer to one =

> compiler which gives rise to another question.=C2=A0 What are the platfor=
ms =

> that Ofono aims to support today?=C2=A0 Just Linux?=C2=A0 Linux and other=
s that =

> work by chance by virtue of being compatible?=C2=A0 Others?
> =


 From the beginning oFono was designed to be Linux only.  This allows us =

to use Linux specific features and not worry about weird OS abstractions.

Regards,
-Denis

--===============6344327748727043466==--

