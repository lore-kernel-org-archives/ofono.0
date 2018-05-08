Content-Type: multipart/mixed; boundary="===============5083228590426032640=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT commands in U0001AT+FOOBAR form
Date: Tue, 08 May 2018 16:58:47 -0500
Message-ID: <7c430d01-d7e3-8473-03c7-c1bf3eb236c5@gmail.com>
In-Reply-To: <20180508214407.GA5226@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5083228590426032640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 05/08/2018 04:44 PM, Pavel Machek wrote:
> Hi!
> =

> I have a motorola droid 4 here; it uses gsm 07.10 multiplex. Over
> that, there are AT commands, but prefixed with serial numbers, in
> U0001AT+FOOBAR form. Corresponding reply then has U0001 prefix, too.
> Has anyone seen that before? Any hints for me trying to add the
> support?
> =


I've never seen anything like it.  The 07.10 was explicitly designed so =

that the AT command processor didn't need to know or care whether it was =

connected directly to the serial port or to the multiplexer.  E.g. AT =

commands should not be modified in any way.

Are you use this is a 07.10 multiplexer and not something else?  What is =

the serial number exactly? Serial number of the multiplexer channel or ?

I would look into gatchat/gatmux.c and see if you can implement a new =

GAtMuxDriver specifically for this hardware.

Regards,
-Denis

--===============5083228590426032640==--

