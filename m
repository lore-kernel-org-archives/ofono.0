Content-Type: multipart/mixed; boundary="===============0722081525604214248=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/6] cdmamodem: Add serving system identifier support
Date: Thu, 24 Nov 2011 01:03:04 -0600
Message-ID: <4ECDEC28.4020505@gmail.com>
In-Reply-To: <4ECE8064.7030803@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0722081525604214248==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 11/24/2011 11:35 AM, Philippe Nunes wrote:
> Hi Denis,
> =

> On 11/18/2011 04:18 PM, Denis Kenzior wrote:
>> Hi Philippe,
>>
>>>> I would also like to see how you're planning to use this information in
>>>> the core, before reviewing this patch in detail.  Do note that after
>>>> taking a quick peek at Huawei CDMA manuals and ModemManager, I very
>>>> much
>>>> doubt that +CSS is what you want to use in the first place.
>>>
>>> I'm really not familiar with Huawei CDMA AT commands but looking to the
>>> command interface specification from Huawei and to TIA/EIA/IS-707, I
>>> can't see other solution than the serving system query to retrieve the
>>> SID. Also, I don't see any unsolicited result codes which could bring
>>> such information.
>>>
>>> Note that this AT command seems supported by Huawei cdma modem according
>>> the first revison of TIA/EIA/IS-707 (here, the band class is not
>>> supported, neither the PREV field).
>>>
>>> Now, it's true that we would need to retrieve also the NID (as stated in
>>> TODO), but so far, I don't see how...
>>
>> I don't really have the answer, but take a peek at ModemManager.  +CSS
>> is not how it retrieves SID in the most common case.  In fact it doesn't
>> even do it via AT commands.  If that's the case, then you might want to
>> rethink this implementation completely.
>>
>> Regards,
>> -Denis
>>
> =

> Looking to the modem manager, the priority is indeed to retrieve the SID
> using the qcdm port com (thanks to the result of a radio status query).
> In case of error, there is however a fallback to use the AT command
> +CSS. Also, if no qcdm port is available, the SID is retrieved  by using
> this AT command (please refer to 'legacy_get_serving_system').
> =

> Note that in modem manager, there is also a special treatment for Huawei
> modem which use the IS-707-A format (no band and class).

I also noticed various comments stating that +CSS does not report any
information when registered to EV-DO and it seems that the Huawei driver
doesn't even bother using fallback mechanisms for EVDO capable hardware
in the first place.  But maybe I'm not reading the code right...

> =

> So far, the AT command "Serving system" seems relevant. Now, do you
> expect us to communicate also through the qcdm port when using cdma modem?

Have you tested that your theories work?  Right now I'm seeing you
making lots of assumptions, and moving code from the huawei specific
driver to some generic driver when in fact no such generality exists.
CDMA does not have an AT command standard ;)

And yes, if the AT command does not do what we need, then using QCDM
would be required.

Regards,
-Denis

--===============0722081525604214248==--

