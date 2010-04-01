Content-Type: multipart/mixed; boundary="===============6418468879032541207=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Access to SIM card when Modem is not "Powered"
Date: Thu, 01 Apr 2010 10:07:51 -0500
Message-ID: <201004011007.52611.denkenz@gmail.com>
In-Reply-To: <k2m80fd4e751004010214r8f0ca85dx3675b4a02eacf505@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6418468879032541207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> I want to prevent core from exiting while a modem is in transitional
> state. Before ofonod terminates, it calls disable and waits until
> Powered gets false. I'd rather change Powered to false immediately
> (when modem shutdown starts) but still keep waiting until modem is
> properly powered down.

So the core exits once modems have been powered down and plugins unloaded. =
 We =

established that already.  I already considered the powered to false =

immediately semantic and discarded it in favor of the current one.  Please =

present an actual argument / use case why you think powered going immediate=
ly =

to false is better than the current implementation.

> It seems to me that Marcel and Aki want to control TX power with the
> Powered property. (BTW, there already is a post-sim mechanism to
> control the RX/TX, namely Register/Deregister.)

Register / Deregister refer to something else entirely actually, and the =

modems that do allow Deregister still keep RX/TX circuit on for emergency =

calls.

I think you're expecting oFono to provide more information that it actually =

wants or needs to.  In the end it is up to the modem driver to decide what =

powered off means.  Most simply keep the TX/RX circuits off and the SIM pow=
ered =

up, others (like calypso) physically power off the modem.  But even oFono =

doesn't know nor care.

> Currently I'm using config to determine if the isimodem should or
> should not control the modem and which phonet device it should or
> should not use. It is used to determine if ofonod is run with maemo5
> cellular daemons or without them.

You're not helping your case here ;)  Why should oFono care about this use =

case?

In the end I'm fine if you want to implement ofono_modem_unregister that ta=
kes =

the modem object off DBus and resets the driver but keeps the attributes =

around.  I know Marcel wanted this anyway for something else.

> You don't seem to handle modem resets at all. Once atdriver gets so
> far, other hardware will benefit, too.

As you mentioned earlier, modem resets are handled by setting the modem =

powered=3Doff then true.  =


> What we miss from the core is a way to do asynchronous cleanup
> (separate from Powered). A shutdown() method in modem driver and
> corresponding callback, like ofono_modem_shutdown_ready(). This way we
> can do what ever N900 requires us to do and there is no need to touch
> other drivers.
> =


Send a patch with your proposal.  So far I like the idea of disable having =
a =

hint on whether a shutdown is in progress more than an explicit shutdown =

method.  =


Regards,
-Denis

--===============6418468879032541207==--

