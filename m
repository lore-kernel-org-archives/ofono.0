Content-Type: multipart/mixed; boundary="===============0876696026359098367=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 17/20] atmodem: add lte specific functions
Date: Tue, 12 Apr 2011 08:56:54 -0500
Message-ID: <4DA45A26.2050006@gmail.com>
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F1EBB1FD@fioues08.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0876696026359098367==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>> This is really not working out, since you still need to get =

>> the interface for this context.  The fact that a context is =

>> active does not necessarily mean that all the resources have =

>> been properly allocated.
>> Namely a gprs-context allocated and all the implications =

>> (e.g. AT channel dedicated to the gprs-context is taken, ppp =

>> / high speed data connection established, etc.)
>>
>> Only the core can do the context allocation, so you still =

>> need to let the core decide what to do.
>>
> =

> I agree on your comments here.
> Infact have missed out to put a todo here on interface assignment so
> that this can be taken up when we work with real modem.
> =


Interface assignment is not going to happen here, please re-think this
entire approach.  You really need to let the core allocate a context
properly.

>>>  	if (g_at_chat_send(psd->chat, "AT+CGREG?", cgreg_prefix,
>>>  				at_cgreg_cb, cbd, g_free) > 0)
>>>  		return;
>>
>> This is really just a bad idea.  The core needs to understand =

>> the concept of CEREG properly, not try to hide this in the driver.
>>
> Intention here is to hide to the core on details of registraion
> technology.
> If core needs these awareness and want to fire relevent
> API/functionality based on current access tech, would bring in new APIs
> to driver for 3G registraion status and LTE registraion status.
> This will also result in core to base it behaviour depending on acess
> technology.

Please get this idea out of your head.  The core should know about LTE
specific details.  Changing the core is not something to be afraid of.

The driver should not be hiding anything besides manufacturer specific
details.  The philosophy behind oFono's drivers has always been to make
them dumb as rocks.  If you're trying to make the driver smart, then you
are already breaking one of the primary design principles.

Regards,
-Denis

--===============0876696026359098367==--

