Content-Type: multipart/mixed; boundary="===============4259727170981374647=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [BUG] [MBM] mbm_disconnect(..) and reopen_callback(..) gives
 oFono seg fault
Date: Tue, 11 Jan 2011 10:13:51 -0800
Message-ID: <1294769631.3873.28.camel@aeonflux>
In-Reply-To: <3ED83A9DB3B6D94CA68BF7C03F2981D35318CA3C39@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4259727170981374647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tomasz,

> =

> I am using MBM modem in oFono and I have run into a problem with
> =

> reopen_callback(..) function.
> =

> I think you might be interested in looking into this as an author
> =

> of the code.
> =

>  =

> =

> The situation is as follow:
> =

>  =

> =

> 1. connect modem to USB port
> =

> 2. Power the modem up: Modem.SetProperty( Powered =3D True )
> =

> 2a. oFono is in the middle of enabling process
> =

> 3. disconnect modem from USB port
> =

> 2b. oFono is still in the middle of enabling process, and modem is not
> marked
> =

>     as enabled
> =

> 4. mbm_disconnect(..) is called, gprs atom removed,
> reopen_callback(..) is set
> =

>    to be called in 1 second delay with data->reopen_source timer
> =

> 5. mbm_remove(..) is called, notice that at this point the
> mbm_disable(..)
> =

>    function call is not called as modem is not enabled yet, and the =

> =

>    reopen_callback 1 second timer is still running.
> =

> 6. timer expiries and as a result reopen_callback(..) is called. At
> this
> =

>    point modem is already removed and function accesses an already =

> =

>    freed memory
> =

> 7. oFono crashes with segmentation fault
> =

>  =

> =

> Normally reopen_callback timer would be removed in mbm_disable(..)
> called
> =

> if enabling process has finished.
> =

>  =

> =

> The easy solution is to add removal of reopen_callback timer in
> mbm_remove(..)
> =

> but I can imagine a race condition then. It might happen that during
> heavy load
> =

> time between mbm_disconnect(..) and mbm_disable(..) or mbm_remove(..)
> can
> =

> be longer than 1 second resulting in call to reopen_callback(..)
> during hardware
> =

> disconnection process. Though I am not sure what can happen here, if
> this will
> =

> result in segmentation fault or it would just execute without any side
> effects.
> =

>  =

> =

> I have also noticed that other vendors don=E2=80=99t go with delayed
> =

> reopen_collback(..) at all. They usually try to reopen directly
> =

> in mbm_disconnect(..).

so the disconnect is called when the modem hangsup the TTY. And that
happens when closing a PPP session. In case of MBM that is only used for
MMS context setups.

So just removing the time from disable callback should be just fine.
Care to send a patch for it?

Regards

Marcel




--===============4259727170981374647==--

