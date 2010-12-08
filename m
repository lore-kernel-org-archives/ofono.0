Content-Type: multipart/mixed; boundary="===============1529586602571075467=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] sms: store pending tx pdus on disk
Date: Wed, 08 Dec 2010 05:01:22 -0600
Message-ID: <4CFF6582.6000300@gmail.com>
In-Reply-To: <20101207145758.26059ea5@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1529586602571075467==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/07/2010 04:57 PM, Kristen Carlson Accardi wrote:
> On Mon, 06 Dec 2010 20:38:58 -0600
> Denis Kenzior <denkenz@gmail.com> wrote:
> =

> <snip>
> =

>>> +	/*
>>> +	 * file name is: imsi/order in tx_queue-uuid/order of pdus
>>> +	 */
>>> +	if (write_file(buf, len, SMS_BACKUP_MODE,
>>> +				SMS_TX_BACKUP_PATH_FILE, imsi, id, uuid,
>>> +				seq) !=3D len)
>>> +		return FALSE;
>>> +
>>
>> And where are you taking care of storing the other needed information?
>> e.g. the tx_queue entry flags, retry count, etc?
> =

> I can easily add the flags and retry count.  As far as the "etc"
> that you mention, the only other information I see would be
> entry->cb and entry->data, which I was thinking might have to
> get lost.  I am not sure how to persist that information on
> disk - do you have any suggestions?

There's really no way to persist these, so losing them is fine for now.
 The only entity who makes use of the callback is the stk atom, and
those sms messages should not be serialized to disk.  e.g. we should not
try to persist messages that do not have at least the
OFONO_SMS_SUBMIT_FLAG_EXPOSE_DBUS set.

Regards,
-Denis

--===============1529586602571075467==--

