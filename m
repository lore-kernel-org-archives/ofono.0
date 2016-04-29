Content-Type: multipart/mixed; boundary="===============8223711242958411766=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Add Support for Sierra MC73xx
Date: Fri, 29 Apr 2016 11:01:29 -0500
Message-ID: <57238559.9040505@gmail.com>
In-Reply-To: <57238389.7000408@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8223711242958411766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 04/29/2016 10:53 AM, Martin Chaplet wrote:
>
>
> On 29/04/2016 17:44, Denis Kenzior wrote:
>>
>>>
>>> This card is mainly QMI but also have Diag, NMEA and AT interfaces
>>> (ttyUSB). I think that's why he did it in setup_sierra.
>>>
>>
>> What is the AT interface capable of?  Can this modem be driven using
>> AT commands instead?  Would certainly be easier to debug.
>
> All main commands are available ( ETSI) but I don't think PPP can be used.
> Additionnaly, it's a 4G modem, using PPP layer instead QMI will reduce
> performances, isn't it ?

You definitely don't want ppp.  Besides, ppp requires 2 functional AT =

ports, and it looks like this card has just one.

Does Sierra provide network management via vendor AT commands?

>
> Do you mean I can use an "hybrid" mode using modem management through AT
> and network through QMI ?

This is quite possible as well.

>
>>
>>>>
>>>> Your modem doesn't seem to want to read anything from the SIM.  So
>>>> that is why your gprs isn't showing up.
>>>>
>>>> Do you have a SIM in there or a PIN set?
>>>
>>>
>>> OK, so I understand that Data feature is detected by scanning SIM
>>> capabilities + chip capabilities (UMTS, LTE, ...)
>>> Am I right ?
>>
>> Sort of.  oFono is a full telephony stack, so we expect the basics to
>> be provided.  IMSI availability tells us that the SIM has been
>> initialized to the point that it is useable.  E.g. PIN has been
>> unlocked/entered.
>>
> OK, I see.
>>>
>>> My SIM doesn't have PIN and I can use Standard QMI tools (libqmi) to
>>> bring up a connection.
>>> I will so investigate around SIM QMI requests / replies.
>>
>> Are sim operations supported / working on this modem with libqmi?
> Yes.
> Please find few tests below
>
> $ qmicli -d /dev/cdc-wdm0 --dms-uim-get-imsi
> [/dev/cdc-wdm0] UIM IMSI retrieved:
>          IMSI: '208103790757141'
>
> $ qmicli -d /dev/cdc-wdm0 --dms-uim-get-state
> [/dev/cdc-wdm0] UIM state retrieved:
>          State: 'initialization-completed'
>
> $ qmicli -d /dev/cdc-wdm0 --dms-uim-get-pin-status
> [/dev/cdc-wdm0] PIN status retrieved successfully
> [/dev/cdc-wdm0] PIN1:
>          Status: disabled
>          Verify: 3
>          Unblock: 10
> [/dev/cdc-wdm0] PIN2:
>          Status: enabled-not-verified
>          Verify: 2
>          Unblock: 10
>

This looks to be in agreement with what oFono is obtaining from the =

drivers/qmimodem/sim.c driver.  However, qmi_read_transparent and =

qmi_read_record don't seem to be reporting proper values.

Does libqmi actually have low-level sim read capability?

Another thing to try would be to implement read_imsi() method for =

drivers/qmimodem/sim.c.  This should get you to the point where gprs is =

initialized even if all low-level reads from the SIM fail.

Regards,
-Denis

--===============8223711242958411766==--

