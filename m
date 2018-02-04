Content-Type: multipart/mixed; boundary="===============0777734966563155915=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Plugin infrastructure
Date: Sun, 04 Feb 2018 18:19:16 +0100
Message-ID: <0238d65e-d24f-06af-7e56-bc33da8b22d6@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0777734966563155915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I was reading through the ofono code and I see that there's a lot of =

code in place to support external plugins.  As things currently stand, =

however, ofono can only be built with _builtin_ modules, so all this =

plugin infrastructure is totally unused.  So I had a couple of questions =

about this:

i)  Is there any value in keeping the plugin infrastructure in place? =

...or would an effort to remove it be valued?

ii)  Does anyone actually use the include/exclude module patterns to =

prevent "plugins" (modules) from being automatically loaded?

I could imagine marking all module init/exit functions with GCC =

attributes "constructor/destructor" and have them automatically and =

unconditionally initialized at startup.  This would, however, render the =

exclude pattern option useless...

iii) Of course, using GCC attributes ties the project closer to one =

compiler which gives rise to another question.  What are the platforms =

that Ofono aims to support today?  Just Linux?  Linux and others that =

work by chance by virtue of being compatible?  Others?

Thanks,
Jonas

--===============0777734966563155915==--

