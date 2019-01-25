Content-Type: multipart/mixed; boundary="===============3529659672034463627=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Reason ofono flakeyness
Date: Fri, 25 Jan 2019 17:29:05 +0100
Message-ID: <20190125162905.GA7647@amd>
In-Reply-To: <20190120155529.GE5540@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3529659672034463627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> > > OK I think I found the reason fo ofono doing a variable
> > > number of commands on start-up with sudo test/enable-modem.
> > > =

> > > There seems to be some kind of issue with handling of
> > > commands and results in ofono. See the logs below for
> > > test/enable-modem. The AT+SCRN=3D0 is sent and then AT+CFUN=3D1
> > > without waiting for results from the previous command :)
> > > =

> > > Is there maybe a missing sync somewhere after writes?
> > =

> > No idea. I just copied the code from other drivers and it seemed to
> > work for me.
> =

> Yeah presumably that works for serial ports.

Still not sure what is going on there. Part of the problem seems to be
ofono expects serial protocol, and will happily split & batch things
together, but motmdm is really packet-based.

Few questions:

drivers/mfd/motorola-mdm.c:

        /* Prepend Motorola custom packet numbering */
        snprintf(cmd, cmdlen, "U%04i%s\r", mot_dlci->id, buf);

We already have \r or \n from the user. Will this add extra one?

I guess this will not work with embedded zero bytes...

Plus it seems kernel auto-splits stream from user into packets...

motmdm_cdev_write:

static ssize_t motmdm_cdev_write(struct file *file, const char __user
*buf,

...should it work byte-by-byte? This way if userland sends
AT+FOO=3D1\rAT+BAR=3D2\r, it will be sent as a single packet, which is
probably wrong thing to do.

...should it also treat ^Z as an end of packet? In case of SMS
sending, AT+GCGMS=3D should go in one packet and hex data in another
one, if I understand things correctly....

Best regards,
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============3529659672034463627==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFseExPVkVBQ2drUU1PZndhcFhiK3ZKVXBnQ2ZaZXdtYTh1SnZwRzA4M2RHWkhkZEowK3YK
OC9rQW4yeHp1dlJWR3g0cSthVzNlRjNMUHAwN0k2K2oKPXRKRVkKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============3529659672034463627==--

