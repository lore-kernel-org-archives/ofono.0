Content-Type: multipart/mixed; boundary="===============6359528507981415454=="
MIME-Version: 1.0
From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
Subject: Re: [PATCH 3/4] isimodem2.5: Changes to add isimodem2.5
Date: Thu, 09 Dec 2010 12:36:19 +0100
Message-ID: <4D00BF33.1050801@stericsson.com>
In-Reply-To: <AANLkTinXYaMie6MrsK6gWyfwtYAeN6d46-iy1j-Px3pY@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6359528507981415454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,
> The CBS topics set is simply not implemented in the current cbs
> driver. I suggest you create a patch for adding that into the current
> driver.
>
>    =


> And same for the clear_topics callback.
Yes, I  might be able to do that. I can not test it though, I haven't =

got any isimodem HW.
I assume you mean submitting a patch to the isimodem for this?

> This has no business being in the isimodem driver. I suppose it was
> included by mistake.
>    =

Yes, sorry.
>
> So the IMEI is not stored on the modem at all. This obviously needs a
> quirk, but I wonder if it would be cleaner to handle this in the modem
> plugin. See for example how GPIO lines are handled in the n900 driver.
>
>    =

Right, we will look into that and probably get back to you on this with =

questions.


> Is there actually anything different here, except for the name change?
> It's using a forked version of GIsiPipe, but I'm pretty sure we can
> just add the missing bits into the existing GIsiPipe class.
>    =

Yes, that could be a solution.
> Just adding the decoding for NET_MODEM_ subblocks here would be
> enough. In fact, these subblocks look almost identical to the existing
> NET_ subblocks, so adding just extra case statements with the new
> codepoints would probably work, too.
>    =

That would certainly look neater.  :-)

> I think this is a bad idea. I know you're using NET_CS_CONTROL_REQ
> here to implement the unregister callback, but the this is basically
> just wrapping existing PN_MTC functionality. In general, ISI modems
> don't seem to understand what a deregister even means.
>
> In fact, even the D-Bus method seems of little value, and I would
> remove it altogether. In any case, leaving this unimplemented is my
> preference.
>    =

Ok, we can see if this works for us, but you are probably right.

> This is different from the current netreg driver. However, it's easy
> enough to alternate, see below.
>    =

> I would suggest probing for both PN_NETWORK and PN_MODEM_NETWORK here.
> Then which ever answers first gets used. After we know with which
> resource we're working with, overloading a few of the ISI messages is
> enough to make this driver work with both versions of modems.
>    =


Seems pretty straighforward.

> I didn't go through all of the patch, but from what I can see, we can
> pretty well fold the WG2.5 modem support into the existing drivers.
>    =

We'll get back to you on that when we have had another look at this and =

your other suggestions.

Thanks for your comments.  :-)


Best Regards,
Jessica

--===============6359528507981415454==--

