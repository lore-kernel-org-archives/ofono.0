Content-Type: multipart/mixed; boundary="===============2913687476666774363=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: Ofono LTE modems and connman services
Date: Mon, 26 Feb 2018 17:30:56 +0100
Message-ID: <6216e0ff-4195-a3ea-4e73-494642855bb3@kerlink.fr>
In-Reply-To: <4a5f9819-3efc-20ed-4080-e958bafabf2a@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2913687476666774363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,


On 02/26/2018 05:12 PM, Denis Kenzior wrote:
> Hi Jonas,
>
> On 02/26/2018 08:37 AM, Jonas Bonn wrote:
>> The following issue is causing us some grief and I really need some =

>> guidance on how to approach this. This is being sent to both the =

>> ofono and connman mailing lists because it's not really clear to me =

>> who's doing the right/wrong thing here...
>>
>> The connman ofono plugin does the following:
>> i)=C2=A0 It powers up (enables) the modem
>> ii)=C2=A0 If cellular tech is enabled, it brings the modem online
>>
>> For an LTE-modem, this second step results in a default bearer being =

>> attached and thereby the modem is 'connected'.=C2=A0 The third connman =

>> step, setting the ofono context to Active, is not required for LTE; =

>> the context becomes 'Active=3Dtrue' right away.
>>
>> The above effectively means that it's not possible to have an LTE =

>> modem that does not auto-connect (in connman terms).
>>
>
> There are multiple possible scenarios here, the two most common ones are:
>
> 1. Default attach APN is an internet context
> 2. Default attach APN is an IMS context
>
> The network provider usually behaves in way 1 or 2 above.=C2=A0 We can =

> control the default attach context to some degree by using =

> org.ofono.LongTermEvolution.DefaultAccessPointName
>
> For this to work nicely you really need automatic context provisioning =

> to work so that the various APN types are known ahead of time.
>
> Either way, when the context is auto activated by the modem it should =

> tell what APN ended up being used.=C2=A0 Ideally that APN _should_ match =

> one of the provisioned contexts.
>
>> Now the APN that ofono sets on the LTE context is 'automatic'; that =

>> was selected because connman _requires_ some APN or else it ignores =

>> the context altogther.
>
> That would seem to be a driver issue. drivers/qmimodem/gprs-context.c =

> even has a TODO entry in there...
>
>>
>> If the modem roams away from LTE connectivity and wants to fallback =

>> to UMTS/GSM, it needs another context with a valid APN.=C2=A0 So now the =

>> modem has two 'internet' contexts ('automatic' and APN) which connman =

>> presents as two distinct services.
>>
>
> This is obviously wrong.=C2=A0 If the modem roams onto 3G then the contex=
ts =

> should be preserved.=C2=A0 There should still be a single internet contex=
t...
>
>> These two services, as far as I can tell, end up competing with each =

>> other when connecting and a mess ensues... if the lower numbered =

>> context is the 3G context, connman goes into an endless loop =

>> attempting to set it Active and continuously failing when the tech =

>> switches to LTE.
>>
>
> Yeah, no wonder...
>
>> The question is, what are the expectations here:
>> i)=C2=A0=C2=A0 What does it mean for connman to see two 'internet' conte=
xts =

>> since it sets up two services for them?
>> ii)=C2=A0 How is a modem supposed to roam between LTE and UMTS/GSM =

>> networks when one requires an APN and the other does not.
>> iii) Not auto-connecting an LTE modem means not bringing it online; =

>> what implications does this have for connman?
>>
>> The above is currently a bit of a confusing mess and both ofono and =

>> connman get themselves tied in a knot when the modem switches between =

>> LTE and non-LTE techs.=C2=A0 Any guidance on how to approach this would =
be =

>> appreciated.
>>
>
> The answer is to just fix your oFono driver.
I had this issue with QMI modems. As a workaround, I have disabled =

auto-activation. This is just a workaround but here is my local patch:

 From aaee53f19adbf7a4dca00366f6f7ae2ddfd4b580 Mon Sep 17 00:00:00 2001
From: Christophe Ronco <c.ronco@kerlink.fr>
Date: Tue, 9 May 2017 17:02:45 +0200
Subject: [PATCH] qmimodem: no automatic activation in LTE

If a SIM connects in LTE and if an APN is provisionned for
this SIM, we end with 2 contexts, one automatically activated
and the other ready to be activated.
That's confusing for connman. To avoid that, simply avoid
automatic connection if techno is LTE.
That's only a workaround because LTE should work without any APN
provisioned.

diff --git a/drivers/qmimodem/gprs.c b/drivers/qmimodem/gprs.c
index a80d55f..51909cd 100644
--- a/drivers/qmimodem/gprs.c
+++ b/drivers/qmimodem/gprs.c
@@ -74,17 +74,17 @@ static int handle_ss_info(struct qmi_result *result, =

struct ofono_gprs *gprs)
 =C2=A0=C2=A0=C2=A0=C2=A0 if (!extract_ss_info(result, &status, &tech))
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -1;

-=C2=A0=C2=A0=C2=A0 if (status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERE=
D)
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (tech =3D=3D ACCESS_TECHNOLOGY_EU=
TRAN) {
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* On LTE we are =
effectively always attached; and
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0* the defau=
lt bearer is established as soon as the
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0* network i=
s joined.
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0*/
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* FIXME: query d=
efault profile number and APN
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0* instead o=
f assuming profile 1 and ""
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0*/
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ofono_gprs_cid_ac=
tivated(gprs, 1 , "automatic");
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 //if (status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTE=
RED)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 //if (tech =3D=3D ACCESS_TECHNOLOGY_=
EUTRAN) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ///* On LTE we ar=
e effectively always attached; and
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0//* the def=
ault bearer is established as soon as the
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0//* network=
 is joined.
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0//*/
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ///* FIXME: query=
 default profile number and APN
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0//* instead=
 of assuming profile 1 and ""
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0//*/
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 //ofono_gprs_cid_=
activated(gprs, 1 , "automatic");
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 //}

 =C2=A0=C2=A0=C2=A0=C2=A0 return status;
 =C2=A0}
-- =

2.7.4



--===============2913687476666774363==--

