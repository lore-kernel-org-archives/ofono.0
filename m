Content-Type: multipart/mixed; boundary="===============1851028006286117243=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] Create network registration driver for hfpmodem
Date: Wed, 04 Nov 2009 11:54:40 -0600
Message-ID: <200911041154.40904.denkenz@gmail.com>
In-Reply-To: <1257267882-12881-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1851028006286117243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

> This driver handles phone informations about registration status, signal
> strength and roaming status listening +CIEV commands.  It also gets the
> Network Operator name with +COPS commands.

This patch has been applied.  I just had to do some _very_ minor cleanups o=
f =

style.

Unfortunately I cannot test the hfp registered -> roaming and roaming -> =

registered scenarios.  So if someone could confirm that this works I'd =

appreciate it

Regards,
-Denis

--===============1851028006286117243==--

