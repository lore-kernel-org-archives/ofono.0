Content-Type: multipart/mixed; boundary="===============2811789384997861519=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 03/18] gathdlc: add mechansim to detect '+++' escape
 sequence
Date: Thu, 31 Mar 2011 17:40:38 +0200
Message-ID: <4D94A076.5050902@linux.intel.com>
In-Reply-To: <4D949CF5.8080400@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2811789384997861519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 31/03/2011 17:25, Denis Kenzior wrote:
> Hi Guillaume,
>
>>>> +suspend:
>>>> +    /*
>>>> +     * If the suspend timeout still exists,
>>>> +     * delete it.
>>>> +     */
>>>> +    if (hdlc->suspend_timeout>   0)
>>>> +        g_source_remove(hdlc->suspend_timeout);
>>>> +
>>>> +    /*
>>>> +     * Restart the counter and reset the ring buffer.
>>>> +     */
>>>> +    hdlc->cmpt =3D 0;
>>>> +    ring_buffer_reset(rbuf);
>>> This sounds like a really bad idea.  What are you trying to accomplish
>>> here?
>> If I don't reset ring_buffer, I am receiving "+++" on GAtServer when I
>> return to command mode and it is blocking following AT commands.
>> I can't send next ATH0 or ATO0. Do you have any idea how to prevent
>> receiving GAtServer to receive it?
> So two issues:
>
> - why are you using ring_buffer_reset instead of ring_buffer_drain(buf, 3=
)?

I didn't think about it :)

> - Why are you doing this here instead of waiting for the guard timeout
> to expire after +++ has been detected?
>

I didn't think that an HDLC frame can contain +++++...
I will change this.

Thanks.

Kind regards,
Guillaume

--===============2811789384997861519==--

