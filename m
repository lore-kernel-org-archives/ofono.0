Content-Type: multipart/mixed; boundary="===============7576022370945878422=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Quick report from PPP testing
Date: Thu, 25 Mar 2010 05:50:23 -0700
Message-ID: <1269521423.11714.166.camel@localhost.localdomain>
In-Reply-To: <20100324203109.36710e62@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7576022370945878422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> > so I just downloaded the Linux kernel via the PPP connection with my
> > Rogers' Novatel UMTS stick.
> > =

> > : < \r\n+CGREG: 2,1,FE38,EBA6\r\n\r\nOK\r\n
> > Registered to GPRS network, roaming=3DFalse
> > : > ATD*99***1#\r
> > : < \r\nCONNECT HSDPA 7.2\r\n
> > oops -- found acked option 2 we didn't request
> > Unknown ipcp option type 130
> > oops, option wasn't acceptable
> > Unknown ipcp option type 132
> > oops, option wasn't acceptable
> > Unknown ipcp option type 130
> > oops, option wasn't acceptable
> > Unknown ipcp option type 132
> > oops, option wasn't acceptable
> > Unknown ipcp option type 130
> > oops, option wasn't acceptable
> > Unknown ipcp option type 132
> > oops, option wasn't acceptable
> > IP Address: 172.28.89.39
> > Primary DNS Server: 64.71.255.198
> > Secondary DNS Server: 64.71.255.253
> =

> option type 130 and 132 are not supported by us right now, which is
> why you see the error.  It is the modem sending us these options.
> type 130 is Primary NBNS server, and 132 is secondary NBNS server.

to speed up the setup process I would propose to just accept these
options and store them internally for reference.

We have the same issue with VPN where it insist on sending us NBNS
servers. On Linux we don't need them but it would be good to not confuse
the modem too much with rejecting these. Just accept and store them.

Regards

Marcel



--===============7576022370945878422==--

