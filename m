Content-Type: multipart/mixed; boundary="===============5817514278126262884=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono running on new Freerunner distribution (was: Palm Pre modem
 plugin)
Date: Mon, 23 Nov 2009 05:11:47 -0600
Message-ID: <200911230511.48052.denkenz@gmail.com>
In-Reply-To: <4B0A6BB9.6050606@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5817514278126262884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dario,

> Well, maybe you missed some of my previous email in this list some time
> ago :)
> I'm the project leader of a new distribution, called NEOPhysis, for the
> Openmoko Freerunner and Niko is the UI team leader.
> We are about 10 people in our team and started from scratch creating a
> new distribution which differs from the others, approaching the system
> concept as an embedded low resources device instead of a micro-desktop
> system.

Ah, I do remember seeing your previous post.  Did not connect the two toget=
her =

though.

> I asked in my previous emails if someone of the oFono team could send me
> a simple C code because all the test code were written in Python (but
> for the telephony part our focus is speed and reliability so its
> mandatory to use a C/C++ framework/middleware) but received no answer,

Actually a reference UI for oFono is something we're still lacking.  We've =
all =

been too busy adding core features.  This is something we want to fix...

> I have just one question: I noticed the Calypso modem registers on the
> network quite slowly (about 1,5-2 mins after powering up) is this
> normal? Can we help you in testing/patching the code to achieve faster
> times (normal phones usually register in seconds).

This might have been related to automatic operator scanning.  Freerunner is =

especially slow on this operation.  The API was changed recently to disable =

this.  Can you test git HEAD to see if this still happens?  =


Regards,
-Denis

--===============5817514278126262884==--

