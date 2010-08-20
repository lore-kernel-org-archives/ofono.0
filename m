Content-Type: multipart/mixed; boundary="===============2879380863729787444=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: About Connection between PPP and linux Sockets
Date: Fri, 20 Aug 2010 15:11:40 +0200
Message-ID: <6d4cb3c3e5039f1b09ef29d548ef1530@chewa.net>
In-Reply-To: <1282304015.23399.210.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2879380863729787444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 20 Aug 2010 13:33:35 +0200, Marcel Holtmann <marcel@holtmann.org>
wrote:
> for a mobile telephony stack, pppd is wrong. Once you understand how 3G
> missuses PPP for IP and PDP context setup, you see what I mean ;)

For mobile telephony, PPP as a _protocol_ is wrong - sure. That being
stated, I don't see how pppd as a _software_ is better or worse than any
other PPP implementation.

Considering the high bandwidth involved in high HSPA categories, and soon
LTE networks, going through user space seems like a bad idea. That's why
Phonet GPRS has its own kernel network device driver, even though Phonet
can also interact with a TUN device. As such, the PPP-only modems are
hopeless. Then why bother rewriting a custom PPP implementation that will
be suboptimal in any case?

oFono PPP is just as non-performant as pppd in case the user-space AT MUX
is used. And it seems worse in case the kernel AT MUX or a raw TTY is used
(pppd has kernel path then).


So I must be missing something.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============2879380863729787444==--

