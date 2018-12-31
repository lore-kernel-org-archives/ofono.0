Content-Type: multipart/mixed; boundary="===============5745679290079224863=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola motmdm support
Date: Mon, 31 Dec 2018 22:54:44 +0100
Message-ID: <20181231215444.GA7336@amd>
In-Reply-To: <20181230212253.GG6707@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5745679290079224863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> Oh, I think I forgot to answer your question regarding PM,
> there's nothing that the user space needs to except to avoid
> polling the /dev/motmdm* devices unnecessarily. And to type
> AT+SCRN=3D0 on /dev/motmdm1 when no notifications for signal
> strength and network status are needed.

Is it possible that epoll() does not work properly with /dev/motmdm*?
I am debugging weird problems with ofonod, and that would be an
explanation...

epoll.poll() should be returning list of file descriptors and if they
are ready. And it seems to work for ttyUSB4 but not for motmdm.

Hmm. And motmdm_cdev_poll() lacks EPOLLOUT() support, right? That
could explain things...

Best regards,
								Pavel

Type "help", "copyright", "credits" or "license" for more information.
>>> f =3D open("/dev/ttyUSB4", "r+")
>>> f.write("AT\r\n")
>>>
>>> import select
>>> epoll =3D select.epoll()
>>> epoll.register(1, select.EPOLLOUT)
>>> epoll.register(f.fileno(), select.EPOLLOUT | select.EPOLLIN)
>>> epoll.poll(1)
[(1, 4), (3, 5)]
>>> select.EPOLLOUT
4
>>> select.EPOLLIN
1
>>> f =3D open("/dev/motmdm1", "r+")
>>> #f =3D open("/dev/ttyUSB4", "r+")
... f.write("AT\r\n")
>>>
>>> import select
>>> epoll =3D select.epoll()
>>> epoll.register(1, select.EPOLLOUT)
>>> epoll.register(f.fileno(), select.EPOLLOUT | select.EPOLLIN)
>>> epoll.poll(1)
[(1, 4)]
>>>


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============5745679290079224863==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd3FrQ1FBQ2drUU1PZndhcFhiK3ZKQUtnQ2NDbFJYOHFuaHhEYXRqYkpjL1R2QURtZlYK
Y1EwQW9KTXBvR1NTTWdrWUlESGFmMDlzRlR6aEM1QVQKPVhSa1cKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============5745679290079224863==--

