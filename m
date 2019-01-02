Content-Type: multipart/mixed; boundary="===============6929978940279452985=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola motmdm support
Date: Wed, 02 Jan 2019 13:15:11 +0100
Message-ID: <20190102121511.GA7002@amd>
In-Reply-To: <20181231222329.GI6707@atomide.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6929978940279452985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon 2018-12-31 14:23:29, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [181231 21:54]:
> > Is it possible that epoll() does not work properly with /dev/motmdm*?
> > I am debugging weird problems with ofonod, and that would be an
> > explanation...
> > =

> > epoll.poll() should be returning list of file descriptors and if they
> > are ready. And it seems to work for ttyUSB4 but not for motmdm.
> > =

> > Hmm. And motmdm_cdev_poll() lacks EPOLLOUT() support, right? That
> > could explain things...
> =

> Hmm yeah maybe.
> =

> FYI, I just pushed a test script into github droid4-sms-tools repo
> for sending SMS and a related kernel fix for ctrl-z termination
> into k.o droid4-pending-mdm-v4.20 branch.
> =

> But that seems to fix a different issue from what you're seeing.

Yes, I can easily work around the problem like this:

It needs huge fixme there, but if you could include it... "always
ready" is better than "never ready".

I'm currently adding code to ofono... I can decode incoming
SMS. Current is here. https://github.com/pavelmachek/ofono

Have you figured out how the incoming calls are supposed to work? I'm
getting this on incoming call:

ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+CIEV=3D1,4,0\n\r
ignoring line
ofonod[2534]: Voice: < ~+CLIP=3D"+420xxxxxxxxx",1,1,"",0,"",0\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+CIEV=3D1,0,0\n\r
ignoring line

ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r
ignoring line
ofonod[2534]: Voice: < ~+WAKEUP\n\r

I probably could use +CLIP as "there's incoming call", but I don't see
anything useful when I hang up and phone should stop ringing. =


Best regards,
								Pavel


diff --git a/drivers/mfd/motorola-mdm.c b/drivers/mfd/motorola-mdm.c
index 2cdc9e8..abf58e3 100644
--- a/drivers/mfd/motorola-mdm.c
+++ b/drivers/mfd/motorola-mdm.c
@@ -706,6 +706,7 @@ static __poll_t motmdm_cdev_poll(struct file *file, pol=
l_table *wait)
 		mask |=3D EPOLLIN | EPOLLRDNORM;
 	if (cdata->disconnected)
 		mask |=3D EPOLLHUP;
+	mask |=3D (EPOLLOUT | EPOLLWRNORM);
 =

 	return mask;
 }

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============6929978940279452985==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd3NxMDhBQ2drUU1PZndhcFhiK3ZKVGZnQ2d2aHh0UURZU0ZQNmlveVduWUhNUHZxcE4K
RUMwQW5SeElHMW93MXFscjJEeitQZ0h3cWJoaDhTb08KPUhPbFoKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============6929978940279452985==--

