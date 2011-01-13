Content-Type: multipart/mixed; boundary="===============3956390631555020034=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Segmentation fault on Downlink data transfer
Date: Thu, 13 Jan 2011 11:00:38 -0600
Message-ID: <4D2F2FB6.5060204@gmail.com>
In-Reply-To: <2A84145621092446B6659B8A0F28E26F470064499D@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3956390631555020034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

> Root cause of this issue is a ring buffer overflow (in gatio received
> data function). The overflow is detected and the DLC3 source context is
> destroyed in dispatch source function. After that the disconnect handler
> is called and try to destroyed the same context.

In general a ring_buffer overflow indicates that the sender is sending
garbage or the consumer is doing something wrong.  Buffer overflows on
GAtIO should not happen.

> =

>  =

> =

> So on this issue there is 2 points:
> =

> 1-      Management of the buffer overflow
> =

> 2-      Buffer overflow cause
> =

>                =

> =

> For the 1^st point, I=E2=80=99m not sure that disconnect DLC channel is t=
he
> solution in case of buffer overflow. I believe that is better to discard
> ongoing packet in the buffer. TCP could survived to packet loss and
> retransmit the packets. Throughput go down but the data pipe is not
> broken for the application.
> =

>  =


Perhaps, but I think it is too early to speculate what we should do with
buffer overflows until we know the cause.

What is the exact setup that you're using?  Are you using GAtMux or the
kernel mux?

> =

> For the 2^nd point, ring buffer overflow happened because data is not
> consume in this buffer. This is a flow control problem. I suspect that
> for some reason the consumer is blocked (not schedule) during some time.
> =


The consumer is synchronous with GAtIO.  The receive_data function is
acting something like this:

- non-blocking reads until the buffer is full or nothing more to read
- Call the read handler
- Check for buffer overflow and kill the channel if it is.

> Ring buffer size is set to 4096 bytes. I realize some test with a ring
> buffer increase to 131072 bytes and I can get long file downlink
> transfer. Probably this size is too much high and  this size  buffer
> need to be tune.
> =


So to me this is sounding like a problem in GAtRawIP implementation.
Can you check whether using synchronous writes to the TUN device fix
your problem?  E.g. in new_bytes of gatrawip.c.

Regards,
-Denis

--===============3956390631555020034==--

