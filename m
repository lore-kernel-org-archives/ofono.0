Content-Type: multipart/mixed; boundary="===============7941700009596061732=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] gprs: Add new external APIs to create,
 activate and remove a PDP context
Date: Thu, 05 May 2011 05:47:29 -0500
Message-ID: <4DC28041.2050704@gmail.com>
In-Reply-To: <4DC2D276.9020008@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7941700009596061732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>> Why do you want to expose STK activated contexts over D-Bus and try to
>> deal with the consequences of this decision?  Having oFono handle them
>> completely internally would simplify the design quite a bit, no?
> =

> Yes, indeed. I thought that the PDP context created by and for oFono
> should be however visible from outside. But I agree,
> STK PDP context should not be handled from outside. So, I will remove
> the D-BUS interface registration for this kind of context.
> =

> Should I also consider to not add this context to the gprs->contexts list?

I don't know yet ;)

> =

> As you can see, I'm using a callback to notify the STK atom when the
> context is activated. Since the context is no more subject to D-BUS
> handling, do you think I could map this callback directly as the
> callback for the gprs_context driver (id
> ofono_stk_activate_pdp_context_cb =3D ofono_gprs_context_cb_t)?
> =

> It implies that I need to setup the interface directly in the STK atom
> but so far, I don't know if you agree with the modifications I did in
> gprs.c regarding how this interface is updated when this is linked to a
> STK PDP context (particularly for the host route).
> Perhaps, even if it duplicates some code, you would prefer to see the
> STK atom updating the interface directly?

Do not do that.  I suggest you look into how STK Send SMS is implemented
and model this somewhat after that.  GPRS atom needs to manage the
contexts and provide private API for activating 'hidden' ones.

Regards,
-Denis

--===============7941700009596061732==--

