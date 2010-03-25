Content-Type: multipart/mixed; boundary="===============5920724440347443651=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: Quick report from PPP testing
Date: Wed, 24 Mar 2010 20:31:09 -0700
Message-ID: <20100324203109.36710e62@kcaccard-MOBL3>
In-Reply-To: <1269476454.11714.155.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5920724440347443651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Mar 2010 17:20:54 -0700
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Kristen,
> =

> so I just downloaded the Linux kernel via the PPP connection with my
> Rogers' Novatel UMTS stick.
> =

> : < \r\n+CGREG: 2,1,FE38,EBA6\r\n\r\nOK\r\n
> Registered to GPRS network, roaming=3DFalse
> : > ATD*99***1#\r
> : < \r\nCONNECT HSDPA 7.2\r\n
> oops -- found acked option 2 we didn't request
> Unknown ipcp option type 130
> oops, option wasn't acceptable
> Unknown ipcp option type 132
> oops, option wasn't acceptable
> Unknown ipcp option type 130
> oops, option wasn't acceptable
> Unknown ipcp option type 132
> oops, option wasn't acceptable
> Unknown ipcp option type 130
> oops, option wasn't acceptable
> Unknown ipcp option type 132
> oops, option wasn't acceptable
> IP Address: 172.28.89.39
> Primary DNS Server: 64.71.255.198
> Secondary DNS Server: 64.71.255.253

option type 130 and 132 are not supported by us right now, which is
why you see the error.  It is the modem sending us these options.
type 130 is Primary NBNS server, and 132 is secondary NBNS server.

--===============5920724440347443651==--

