Content-Type: multipart/mixed; boundary="===============4996758515587670144=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] qmi: support SMS receive on Quectel EC21
Date: Tue, 17 Oct 2017 09:45:10 -0500
Message-ID: <7f81d809-a990-c8af-df30-9b75337e5be7@gmail.com>
In-Reply-To: <20171017134134.0d70b32e@lazus.yip>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4996758515587670144==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 06:41 AM, Alexander Couzens wrote:
> Hi Jonas,
> =

>> Could you explain what you are trying to do here?  Why would you
>> clear the SMS storage every time the modem powers up?
>>
>> I also don't see that ofono actually supports deleting messages from
>> the modem's storage... if you know how this is supposed to work,
>> please enlighten me.

oFono does not manage the message store.  The implicit assumption is =

that all SMS messages are delivered immediately without hitting ME/SMS =

storage.  oFono takes care of notifying the history plugin and sending =

the ACK.

For those devices that don't support immediate delivery it is assumed =

that the sms atom driver takes care of the details.  So on startup the =

driver is supposed to grab all messages from the store, notify the core =

and then delete all of them.  Any subsequent messages that are delivered =

to the store, should be notified up to the core and the storage space freed.

See how the atmodem sms driver does this.  E.g. +CMTI delivery vs +CMT

> =

> the Gobi2000 doesn't accept the routes with TRANSFER_AND_ACK nor
> STORAGE_TYPE_NONE.
> =

> Reading out the store is also useful if the modem is receiving any
> SMS while ofono isn't runing. E.g. while booting, the sms would never
> made it to ofono.

This is a weird case as the modem should not be in radio on mode anyway. =

  But yes this is possible...

> =

> I don't know (yet) how the different routes are working in detail. This
> is on my list. But I've faced edge cases when the NV was full, the
> modem rejects receiving any messages, regardless if the modem should
> save it to it.
> =


On an unrelated note, can you guys look at the WIP mbimmodem plugin and =

see if the parsing/building approach taken there is applicable (in some =

modified form) to QMI?  E.g. to simplify the drudgery of building / =

parsing QMI messages.

Regards,
-Denis

--===============4996758515587670144==--

