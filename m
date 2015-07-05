Content-Type: multipart/mixed; boundary="===============2068538883939924844=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Support for Telt LE920 Modem in ofono
Date: Sun, 05 Jul 2015 07:16:45 -0500
Message-ID: <5599202D.90509@gmail.com>
In-Reply-To: <loom.20150706T193601-523@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2068538883939924844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vidhya,

 >
> Hi Denis,
>
> We have Telit LE920 modem , and working on providing support for LE920 wi=
th
> ofono.It is currently not been recognized, after check_modem_list, it is
> returning. Perhaps, we have to add LE920 modem specific details to ofono =
driver.
> Can you please let us know what modem specific details we need to enter a=
nd
> in which part of code/configuration files?

There are two modem detection plugins at the moment.

If your modem is USB based, then plugins/udevng.c is what takes care of =

it.  Adding a new modem subtype is generally a matter of tweaking a few =

of the look up tables inside.  (e.g. vendor_list[], driver_list[], etc).

If you modem is using a Serial interface, then plugins/udev.c is used =

along with a udev rule.  See doc/calypso-modem.txt for an example of this.

Regards,
-Denis


--===============2068538883939924844==--

