Content-Type: multipart/mixed; boundary="===============5520090740173999313=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 07/20] SMS: implement SHA256-based message IDs [incomplete]
Date: Thu, 29 Jul 2010 16:37:44 -0500
Message-ID: <4C51F4A8.4040603@gmail.com>
In-Reply-To: <1280438777.16826.66.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5520090740173999313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 07/29/2010 04:26 PM, Inaky Perez-Gonzalez wrote:
> On Tue, 2010-07-27 at 10:03 -0700, Denis Kenzior wrote: =

>> Hi Inaky,
>>
>>> -unsigned int __ofono_sms_txq_submit(struct ofono_sms *sms, GSList *lis=
t,
>>> -					unsigned int flags,
>>> +struct tx_queue_entry * __ofono_sms_txq_submit(struct ofono_sms *sms, =
GSList *list,
>>> +					unsigned int flags, unsigned ref,
>>>  					ofono_sms_txq_submit_cb_t cb,
>>>  					void *data, ofono_destroy_func destroy);
>>
>> I disagree with this, you're modifying an ofono internal API function to
>> return a structure which is opaque and cannot be manipulated.  I'd
>> rather see you returning a struct sms_uuid...
> =

> I need a handle to operate on. The D-Bus wrappers need something they
> can use to dispose of the structure (call tx_queue_entry_destroy() on
> the error path) and to pass to sms_msg_cancel(). The structure is not
> manipulated (except for accessing the UUID and #PDUs, which should
> probably be coded out to a helper).
> =

> This could be solved by having at the entry point of those functions or
> wrappers of a lookup function that looks for the UUID in the list of
> messages, but that would be adding more code and wasting time for no
> benefit. I disagree on adding unnecessary steps.
> =


I need to look at this in detail.  Can you simply grab the tx_entry from
the back of the queue for now?  I'm really against modifying txq_submit
right now.

>>> +	/*
>>> +	 * Instead of using the telephone number/address we got from
>>> +	 * D-Bus, we do the reverse formatting, so we get something
>>> +	 * that has been normalized--this is used later and we do it
>>> +	 * here to simplify error handling.
>>> +	 */
>>> +	sms_address_from_string(&receiver, to);
>>> +	if (sms_address_to_hex_string(&receiver, receiver_str)
>>> +	    =3D=3D FALSE)
>>> +		return __ofono_error_failed(msg);
>>
>> Please avoid mixing tabs and spaces for indentation.  And in this case
>> it is more readale to break up the function than the equals line.  E.g.
>>
>> if (sms_address_to_hex_string(&receiver,
>> 				receiver_str =3D=3D FALSE)
>> 	return __ofono_error_failed(msg);
> =

> This is truly a matter of personal opinion; I for one cannot see how
> this is more readable than the other form :)
> =


All coding styles are a matter of personal taste.  For oFono we prefer
the above mentioned style.

Regards,
-Denis

--===============5520090740173999313==--

