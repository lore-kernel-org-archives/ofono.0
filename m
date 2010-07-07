Content-Type: multipart/mixed; boundary="===============6327954310383746206=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 11/23] struct tx_queue_entry: add fields and destructor
Date: Wed, 07 Jul 2010 18:32:33 -0500
Message-ID: <4C350E91.4070304@gmail.com>
In-Reply-To: <1278545069.2327.131.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6327954310383746206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 07/07/2010 06:24 PM, Inaky Perez-Gonzalez wrote:
> On Wed, 2010-07-07 at 16:04 -0700, Denis Kenzior wrote: =

>> Hi Inaky,
>>
>> <snip>
>>
>> ....
> =

>>>  	if (sms->txq) {
>>> -		g_queue_foreach(sms->txq, (GFunc)g_free, NULL);
>>> +		g_queue_foreach(sms->txq, tx_queue_entry_destroy_free, NULL);
>>>  		g_queue_free(sms->txq);
>>>  		sms->txq =3D NULL;
>>>  	}
>>
>> Can we simply unify the two functions and simply call it
>> tx_queue_entry_free?  For symmetry renaming create_tx_queue_entry to
>> tx_queue_entry_new would be nice.
> =

> Makes sense -- thought it cannot be done, but I realized
> sms_msg_cancel() needs a _destroy_free(), not just a _destroy(), so that
> settles that last one. Will do the _create() rename too.
> =

> =


Good, can you resubmit this one separately soonish?  I'm touching this
area of the code because of Andrew's changes for STK Send SMS command
handling.

Regards,
-Denis

--===============6327954310383746206==--

