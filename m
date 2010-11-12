Content-Type: multipart/mixed; boundary="===============1177881749177294424=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Can I modify CallingLineRestriction(the Property of CallSetting)
 value to "disabled" or "enabled"
Date: Fri, 12 Nov 2010 08:36:21 -0600
Message-ID: <4CDD50E5.2060303@gmail.com>
In-Reply-To: <AANLkTi=-4hVwgoT=YmnSMhYNacz3yej1352GoXGHZfT0@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1177881749177294424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 11/12/2010 08:19 AM, Pekka Pessi wrote:
> Hi,
> =

> 2010/11/11 Gu, Yang <yang.gu@intel.com>:
>>> What happens when you make a call? Does call get rejected or do you
>>> get some CSSU indications?
>>
>> Thank you for the comments!
>> After setting HideCallerId to "enabled", and making an outgoing call, th=
e call arrived at another phone as normal, and I didn't see any CSSU indica=
tion. The call settings are listed below, in which the CallingLineRestricti=
on is always disabled. I think this means the network disables this feature=
. I also confirmed with our operator (CMCC), and they said they don't suppo=
rt CLIR.
> =

> They really do not support it. Thanks for the logs.
> =

> There is a Finnish operator (Aino) which does not have CLIR
> provisioned by default, they will reject the calls made with temporary
> CLIR invocation.
> =

> It seems to me that the call-settings API stores the user preference
> to the modem (how that is done is up to the modem). This can lead to
> subtle privacy bugs if user has multiple SIM cards. I wonder if oFono
> should store the CLIR settings in IMSI-specific storage. oFono should
> somehow specify the interaction with the CLIR setting stored in the
> modem, too.
> =


Are you sure?  I actually assume that the network simply replies OK to
the CLIR invocation but doesn't actually honor it.  If this is the case
then no amount of API behavioral changes is going to help here.

Also remember that this is Huawei we're dealing with here.  Have you
tried other vendors?

Regards,
-Denis

--===============1177881749177294424==--

