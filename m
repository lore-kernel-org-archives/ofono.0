Content-Type: multipart/mixed; boundary="===============3032930912824302355=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: ppp
Date: Fri, 13 Nov 2009 12:31:56 +0100
Message-ID: <2db41c0e79c2bd21b6ce7fc373039151@chewa.net>
In-Reply-To: <alpine.LNX.2.00.0911121929570.21838@boatman.intrepnet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3032930912824302355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 12 Nov 2009 19:39:40 +0000 (GMT), Chris Pitchford
<ofono@intrepid.cx> wrote:
> I'm not sure if the requirements of ppp in the kernel have chagned, but
> couldn't something like this be repeated in this situation.. allowing
pppd
> to speak to a local socket/fifo/pair of pipes that is terminated in user
> space?

In my understanding, PPP is a line discipline, meaning it can only run on a
TTY character device device, not just any character device, and definitely
not any random file descriptor.

-- =

R=C3=A9mi Denis-Courmont


--===============3032930912824302355==--

