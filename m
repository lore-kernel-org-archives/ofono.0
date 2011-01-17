Content-Type: multipart/mixed; boundary="===============8744720962706810589=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] atmodem: move USSD quirk to probe and use it also for
 STE modems
Date: Mon, 17 Jan 2011 09:58:10 -0600
Message-ID: <4D346712.80109@gmail.com>
In-Reply-To: <1295253723.10484.23.camel@lkunnasl-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8744720962706810589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

On 01/17/2011 02:42 AM, Lasse Kunnasluoto wrote:
> Hi Marcel,
> =

> On Fri, 2011-01-14 at 16:20 +0200, Marcel Holtmann wrote:
>> Hi Lasse,
> =

>>> @@ -314,6 +305,18 @@ static int at_ussd_probe(struct ofono_ussd *ussd, =
unsigned int vendor,
>>>  =

>>>  	ofono_ussd_set_data(ussd, data);
>>>  =

>>> +	switch (data->vendor) {
>>> +	case OFONO_VENDOR_QUALCOMM_MSM:
>>> +	case OFONO_VENDOR_STE:
>>> +		/*
>>> +		* Ensure that the modem is using GSM character set. It
>>> +		* seems it defaults to IRA and then umlauts are not
>>> +		* properly encoded. The modem returns some weird from
>>> +		* of Latin-1, but it is not really Latin-1 either.
>>> +		*/
>>> +		g_at_chat_send(data->chat, "AT+CSCS=3D\"GSM\"", none_prefix,
>>> +							NULL, NULL, NULL);
>>> +		break;
>>> +	}
>>> +
>>>  	g_at_chat_send(chat, "AT+CSCS?", cscs_prefix, read_charset_cb, data,
>>>  			NULL);
>>>  =

>>
>> so we don't really wanna do it this way since other atoms like the
>> phonebook can switch the character sets as well.
>>
> Yes, seems so. If phonebook switches the character set USSD won't get
> notified and vice versa. So in general this should be somehow
> centralized in ofono.
> What about supporting the IRA character set in ofono? It would get us a
> bit forward compared to current situation. Currently USSD functionality
> is quite broken with AT modems having IRA character set, all strings
> sent from NW are ignored in cusd_parse().

So in general it is a really bad idea for atoms to switch the character
set, we made the exception for USSD and Phonebook atoms because there's
no other way according to the spec.

Supporting IRA character set is not really an option since IRA and GSM
7bit have disjoint sets of characters.  The best you can really do is:

- If your modem supports UTF8, then set that for all multiplexer
channels in the modem driver.
- Otherwise set the character set to GSM and do your best to put ussd
and phonebook on separate multiplexer channels.  That is of course
assuming that the CSCS setting is handled per channel.

> =

>> The best is if the STE modem would provide access to the USSD in PDU
>> mode and we can then decode it properly. Using text mode for USSD is not
>> the best idea actually. Same as text mode for SMS is utterly broken ;)
> Don't know if this is possible.

USSD PDU mode is the ideal solution.  If this is not available, then you
will have to jump through all kinds of hoops to get this done properly.

Regards,
-Denis

--===============8744720962706810589==--

