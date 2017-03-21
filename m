Content-Type: multipart/mixed; boundary="===============0674677218534079756=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: Telit LE910V1 - LTE only modem
Date: Tue, 21 Mar 2017 17:50:01 +0000
Message-ID: <4d3d4e53-474b-55ec-b364-242c7e8b67d1@gmail.com>
In-Reply-To: <9039a556-efd6-4c8c-a6ad-d7a4291325b9@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0674677218534079756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis, Piotr,

I have just submitted a patch. Piotr, you probably should add your sign-off=
 on it, as about half of it came directly from you.

I am still a little bit confused about ofono_gprs_cid_activated(). As far a=
s I can see only atmodem calls it. No other driver does that.
The flow of user calling create-internet-context and activate-context seems=
 to work fine with my patch.

I am not sure if a context is automatically created. I can see that the sim=
 card has a few profiles, and the user can select which APN to use, start/s=
top ip network, etc.

Let me know if what I coded is ok. I am happy to make changes as required.
Thanks.

Lukasz


On 20/03/17 23:39, Denis Kenzior wrote:
> Hi Lukasz,
> =

>>> Strictly speaking this statement is correct.  In LTE there's really no =
concept of 'attached'.  We're attached by the virtue of getting onto the LT=
E network (the default bearer is always available).  So there should be no =
need to explicitly issue a set_attached method.
>>
>> The current qmimodem code, calls ofono_gprs_status_notify(NETWORK_REGIST=
RATION_STATUS_REGISTERED) when it receives a notification from the modem th=
at it is fully connected. Is that the correct path to make the gprs context=
 marked as "attached"?
>> If that does not happen, all the dbus context APIs just return an error,=
 and as a result, e.g. connman does not enable the cellular service.
>>
> =

> So as it is today, oFono for LTE expects the following:
> ofono_gprs_status_notify(with registered / roaming)
> and ofono_gprs_cid_activated() for the default bearer.
> =

> The gprs-context driver must then implement read_settings method.  LTE is=
 weird since the contexts can be network activated.  The default bearer is =
'activated' by the modem firmware itself by virtue of obtaining the LTE net=
work registration.  The logic is quite different compared to 2G/3G.
> =

> If you know your AT commands, see how the ubloxmodem driver does this. Pa=
y attention to drivers/atmodem/gprs.c cgev_notify() and drivers/ubloxmodem/=
gprs-context.c.
> =

> We also now have an lte atom.  See doc/lte-api.txt for details.
> =

> If the above isn't possible for QMI, then we might need to tweak the core=
 logic (e.g. src/gprs.c) accordingly.
> =

> Please note that qmimodem driver was developed when we didn't have lte su=
pport, so the logic in there is probably incorrect / inadequate.
> =

>> I can add a change to qmimodem, which will explicitly ask the modem firm=
ware if it is connected, from qmi_gprs_probe() rather than waiting on a sta=
te change notification, which never arrives.
>> Does that make sense?
>>
>> How do you usually test such changes for regressions? I do not have any =
other QMI modems, to verify if I have broken anything in them or not. I thi=
nk the change should be safe, but I cannot be 100% certain.
>>
> =

> We try to catch most regressions during the patch review process.  In the=
 past we had some QA resources performing manual tests, but these resources=
 are no longer available.  Easiest might be to order a few qmi modems and c=
heck if your patches break them :)
> =

> Regards,
> -Denis

--===============0674677218534079756==--

