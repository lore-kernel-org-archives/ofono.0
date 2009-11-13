Content-Type: multipart/mixed; boundary="===============3054328778719554189=="
MIME-Version: 1.0
From: Chris Pitchford <ofono@intrepid.cx>
Subject: Re: ppp
Date: Fri, 13 Nov 2009 11:53:11 +0000
Message-ID: <20091113115311.19074lc2vv2yavms@boatman.intrepid.co.uk>
In-Reply-To: <2db41c0e79c2bd21b6ce7fc373039151@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3054328778719554189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Quoting R=C3=A9mi Denis-Courmont <remi@remlab.net>:

>
> On Thu, 12 Nov 2009 19:39:40 +0000 (GMT), Chris Pitchford
> <ofono@intrepid.cx> wrote:
>> I'm not sure if the requirements of ppp in the kernel have chagned, but
>> couldn't something like this be repeated in this situation.. allowing
> pppd
>> to speak to a local socket/fifo/pair of pipes that is terminated in user
>> space?
>
> In my understanding, PPP is a line discipline, meaning it can only run on=
 a
> TTY character device device, not just any character device, and definitely
> not any random file descriptor.

turns out that the software I mentioned (virtmodem from 1995) does  =

indeed use a pty pair. Although I've not had time during the week to  =

get it running again, I suspect it would probably work on a recent  =

kernel/pppd.

Is the line discipline so much of an issue when using ppp connected to  =

a fake tty? could that not be handed on the proxy side inside ofono?


--===============3054328778719554189==--

