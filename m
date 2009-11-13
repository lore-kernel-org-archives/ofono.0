Content-Type: multipart/mixed; boundary="===============4191696287740095731=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: ppp
Date: Fri, 13 Nov 2009 12:30:21 +0100
Message-ID: <528e30da2dd595aafc78a57a7dfafb0e@chewa.net>
In-Reply-To: <200911121237.30698.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4191696287740095731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 12 Nov 2009 12:37:30 -0600, Denis Kenzior <denkenz@gmail.com>
wrote:
> Unfortunately it is not that simple.  pppd requires a proper kernel file
> descriptor to hand off to the kernel ppp line discipline.  In our
> userspace implementation that is not the case.  1 kernel file descriptor
> is shared by potentially many GAtChat channels using a multiplexing
> protocol. =


You _could_ create a PTS/PTY pair though...

> Hence why we can't reuse the kernel implementation.

...But I am not sure if the PPP line discipline works correctly on top of
/dev/pts.

-- =

R=C3=A9mi Denis-Courmont


--===============4191696287740095731==--

