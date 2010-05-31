Content-Type: multipart/mixed; boundary="===============6402018019533639016=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: RTNL sync or async when creating GPRS Context for STE modem.
Date: Mon, 31 May 2010 09:58:55 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C10579169C3C1BDE@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <201005302246.22317.remi@remlab.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6402018019533639016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

R=C3=A9mi Denis-Courmont wrote:
> > I have started out by doing the RTNL handling async,
> > i.e. registering the RTNL socket with g_io_add_watch etc.
> > But I'm not really happy with the code as it feels
> > unnecessary complex, introduces new states in gprs-context.c. etc.
> =

> Using an event loop makes sense if, and only if, the process blocks as
> far as poll() is concerned. If your ioctl() calls or Netlink requests =

> do not enter the kernel scheduler at any point, then the glib main
> loop will just slows things down - more code, more context switches.

Thanks Denis,
I think a synchronous implementation should be find then.

If I understand RT-Netlink correctly, creating a CAIF Network Interface sho=
uld
not enter the poll() or wait in recvmsg. When sending RTNL newlink message,
the whole newlink operation should execute in the senders thread, and =

response messages be ready in the rtnl sockets receive queue when the send
operation completes. Hence read/poll should not block the thread.

Regards
/Sjur




--===============6402018019533639016==--

