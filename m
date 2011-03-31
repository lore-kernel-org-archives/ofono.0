Content-Type: multipart/mixed; boundary="===============8630471323921965371=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/18] gathdlc: add mechansim to detect '+++' escape
 sequence
Date: Thu, 31 Mar 2011 10:25:41 -0500
Message-ID: <4D949CF5.8080400@gmail.com>
In-Reply-To: <4D943C19.3030501@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8630471323921965371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>>> +suspend:
>>> +    /*
>>> +     * If the suspend timeout still exists,
>>> +     * delete it.
>>> +     */
>>> +    if (hdlc->suspend_timeout>  0)
>>> +        g_source_remove(hdlc->suspend_timeout);
>>> +
>>> +    /*
>>> +     * Restart the counter and reset the ring buffer.
>>> +     */
>>> +    hdlc->cmpt =3D 0;
>>> +    ring_buffer_reset(rbuf);
>> This sounds like a really bad idea.  What are you trying to accomplish
>> here?
> =

> If I don't reset ring_buffer, I am receiving "+++" on GAtServer when I
> return to command mode and it is blocking following AT commands.
> I can't send next ATH0 or ATO0. Do you have any idea how to prevent
> receiving GAtServer to receive it?

So two issues:

- why are you using ring_buffer_reset instead of ring_buffer_drain(buf, 3)?

- Why are you doing this here instead of waiting for the guard timeout
to expire after +++ has been detected?

> =

>>> +
>>> +    /*
>>> +     * Wait for another pause of GUARD_TIMEOUTS ms before returning
>>> to command mode.
>>> +     */
>>> +    hdlc->paused =3D FALSE;
>>> +    hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS,
>>> hdlc_suspend, hdlc);
>>>   }
>>>

Regards,
-Denis

--===============8630471323921965371==--

