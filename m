Content-Type: multipart/mixed; boundary="===============2191066879274297949=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: PIPE use in ofono
Date: Tue, 20 Jul 2010 18:49:08 +0300
Message-ID: <201007201849.09617.remi@remlab.net>
In-Reply-To: <81C3A93C17462B4BBD7E272753C10579169FAB466E@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2191066879274297949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Le mardi 20 juillet 2010 14:33:51 Hemant-vilas RAMDASI, vous avez =C3=A9cri=
t :
> Today's Phonet stack in 2.6.24, gprs interface looks like virtual interfa=
ce
> (similar to TUN) where no connection with real hardware is possible.

Phonet was released in Linux kernel 2.6.27 if I recall correctly.

> I
> can't understand how peps (one on modem and other on linux phonet stack)
> are connected, so that IP packets coming from nokia modem can be forwarded
> to IP stack directly instead of routing from user space using sequence
> socket.

The virtual GPRS network interface runs on top of the Phonet packet socket, =

much like a virtual PPP network interfaces run on top of a TTY port.

The packet socket itself is the Linux-side endpoint of the Phonet pipe betw=
een =

the modem and the Linux CPU.

> Is it possible with today's phonet stack? Is there a need of third
> entity like controller to do this?

That's done with the pep_gprs.c network device driver. However, GPRS signal=
ing =

needs to be done in userspace. This is implemented in oFono already.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net/
http://fi.linkedin.com/in/remidenis

--===============2191066879274297949==--

