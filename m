Content-Type: multipart/mixed; boundary="===============3603525260670676736=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [gprs-provision RFCPATCHv6 0/4] Plugin API for provisioning of
 GPRS context settings
Date: Wed, 26 Jan 2011 12:43:43 +0200
Message-ID: <AANLkTinWmPRj2J6RPVs__7pm-d9yxO17erggMjm1kY9r@mail.gmail.com>
In-Reply-To: <1296035821.1520.100.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3603525260670676736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/26 Marcel Holtmann <marcel@holtmann.org>:
> lets get this merged without support for SPN for now. We can easily add
> this later. So please fix Denis' comments and re-submit this without the
> SPN change.
>
> Andrew is currently looking into fixing the SIM reading race. Once that
> is done we can tackle the SPN part. Feel free to add a TODO item for
> adding access to SPN information.

By SIM race do you mean an atom getting removed while it has a pending
ofono_sim_read?

> Right now I think we need to do that in the SIM atom, store it, and then
> provide it for netreg and other plugins that might want it. However we
> might need to discuss this a bit further.

I think this is actually easy to fix internally to the sim atom. The
first ofono_sim_read() to EFspn would initiate an async read, and any
call to ofono_sim_read() after the fact would pend on that single read
results, or return immediately with cached results if available.

There is still the SIM race problem, but I would really rather solve
that problem by always having all atoms created and removed in the
same callbacks, without returning to mainloop.
Whether atoms register any D-Bus API in certain modem states is then a
different matter.

But the lifetime of all atoms should be the same, and then the SIM
race is again a local matter to the SIM atom to fix. E.g., cancelling
any pending reads it has on the SIM when it gets removed. Simply
removing the driver should take care of this, in fact (at least
isimodem should handle such a thing gracefully).

So I don't see the point in removing the SPN code from provisioning
right now. It is a necessary part of the solution, so at least we need
to keep the task open as long as SPN is not in.

Cheers,
Aki

--===============3603525260670676736==--

