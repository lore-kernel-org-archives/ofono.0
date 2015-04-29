Content-Type: multipart/mixed; boundary="===============6580740984361757682=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Cinterion EHS6 support
Date: Wed, 29 Apr 2015 14:17:45 -0500
Message-ID: <55412E59.3090506@gmail.com>
In-Reply-To: <55412CD7.3030600@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6580740984361757682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

 >
> I understand. I am not sure what the differences are between the tc65
> and the ehs6. I'll speak with Gemalto/Cinterion to get some
> clarification on this.

Sure.  In the past we have found that the modem firmware is similar =

enough that no changes are needed between different modem families from =

the same manufacturer.  There were one or two exceptions of course.

>
> My thought process for splitting it out was along these lines:
>
> At present I am focussed just on supporting a data-connection for one of
> our boards with the EHS6 on it with connman/ofono.
>
> We'll be working with the EHS6 and probably the EHS5 extensively over
> the next few years on a range of board products so I will likely be
> testing out other functionalities for the EHS6 such as voice, sms etc.
> etc. I imagine.
>
> I can prove this out on our hardware and provide any needed patches
> upstream if that is of use.
>
> But we don't plan to make use of the TC65 and so I can't commit to
> ensuring that anything I implement for the EHS6 would work for the TC65,
> or indeed wouldn't break the current TC65 implementation.

Some things can be done by eye-balling the code.  For example, I just =

ran a diff on the code you submitted.  The only difference between =

plugins/ehs6.c and plugins/tc65.c is the vendor quirk for =

ofono_netreg_create.  Something that tc65 also probably needs.

>
> I assumed that the current tc65 code worked, although it wasn't working
> for me on the ehs6, and as I don't know what's' going on there I was
> keen not to make any potentially breaking changes that might cause
> others problems.

I'm not quite sure why that would be the case.  Registering for CIND =

indications that will never come should not cause any significant issues...

>
> Can I come back to you with the response from Cinterion/Gemalto on
> differences/similarities between TC65 and EHS5/6 and then you can decide
> whether the patch needs refactoring?

Sure

Regards,
-Denis


--===============6580740984361757682==--

