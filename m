Content-Type: multipart/mixed; boundary="===============6793726685339236158=="
MIME-Version: 1.0
From: Philip Paeps <philip@trouble.is>
Subject: Re: oFono + Quectel EC25 module: connecting to network,
 ppp0 interface help
Date: Thu, 09 Feb 2017 10:26:40 +0100
Message-ID: <20170209092640.GK57399@rincewind.trouble.is>
In-Reply-To: <CAOZ0rctdUO7HcZmq2zH+6+i=YX=b2QibvsTE51UDbP9CmF1PJQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6793726685339236158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2017-02-08 14:15:05 (-0500), Demetrius Pampouktsis <demech11@gmail.com=
> wrote:
> I'm trying to set up oFono with the Quectel EC25 module. I see that
> support for the U15 has been added so I am sort of piggy backing of
> that.

I think I perpetrated that one.

> After that I made some progress. Using the oFono/test scripts I can
> enable-modem, online-modem, and scan-for-operators. What I can't seem
> to do is connect/setup a network, and ppp interface.

Have you managed to get the modem connected using pppd and chat?  oFono
might not be your problem.

> * Side note I am using connman to manage my networks. I can see the
> cellular technology, and can enable it but there is never a cellular
> service, or ppp0 interface.

There are a lot of moving parts in the connman/dbus/oFono path.  For
developing the drivers, I found just running oFono in the foreground
with OFONO_AT_DEBUG and OFONO_PPP_DEBUG a lot more helpful than using
connman or dbus.

> Any help moving forward to set up the network and interface would be
> helpful.

Have you verified that the modem itself can actually connect etc?  My
customer ran into some very interesting hardware/firmware issues with
the U15.  I would not be surprised if the EC25 exhibited similar quirks
(see the comment in quectel.c:cfun_query() for instance).

Philip

-- =

Philip Paeps
Senior Reality Engineer
Ministry of Information

--===============6793726685339236158==--

