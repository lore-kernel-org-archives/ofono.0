Content-Type: multipart/mixed; boundary="===============6663622623695812287=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH v3 05/26] gathdlc: add mechansim to detect '+++' escape
 sequence
Date: Wed, 04 May 2011 11:14:27 +0200
Message-ID: <4DC118F3.2070201@linux.intel.com>
In-Reply-To: <4DBEA1FC.20800@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6663622623695812287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 02/05/2011 14:22, Denis Kenzior wrote:
> Hi Guillaume,
>
>> @@ -197,6 +257,29 @@ out:
>>
>>   	if (hdlc->destroyed)
>>   		g_free(hdlc);
>> +
>> +	/*
>> +	 * If there were no data pause for GUARD_TIMEOUTS ms,
>> +	 * we try again to check it.
>> +	 */
>> +	if (!hdlc->paused)
>> +		hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS,
>> +							paused_timeout_cb,
>> +							hdlc);
> So you just caused a crash here...

Yes big one, I may have sent you not the right version because I made it =

working.
Abyway, I will work on your version now :)

>> +
>> +	return;
>> +
>> +suspend:
>> +	/*
>> +	 * Restart the counter and reset the ring buffer.
>> +	 */
>> +	hdlc->cmpt =3D 0;
>> +
>> +	/*
>> +	 * Wait for another pause of GUARD_TIMEOUTS ms before returning to com=
mand mode.
>> +	 */
>> +	hdlc->paused =3D FALSE;
>> +	hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS, hdlc_suspend, h=
dlc);
>>   }
>>
>>   GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
> Some general comments:
>
> Your implementation assumes too much about the contents of the read
> buffer.  You have to make sure that it works even in different timings
> of the received information.  You should also not try to process the
> escape sequence through the main HDLC parser...
>
> I've pushed my own version, which I have not tested at all.  The
> relevant commits are 94d6d505eeda4db0a28aea99bf3ab23a62a65f2c and
> dc86e864463a61d3f99a21c948c11ba274c6ef84.  Please review and let me know
> how well it works.
>

At first sight, it sounds ok, I will test it now.

Kind regards,
Guillaume

--===============6663622623695812287==--

