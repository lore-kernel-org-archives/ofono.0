Content-Type: multipart/mixed; boundary="===============7533839782000726204=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: patch to fix BMC #13679 Huawei EM770: ofonod crash when
 disable/enable 3G technology
Date: Fri, 04 Mar 2011 09:19:54 -0600
Message-ID: <4D71031A.20504@gmail.com>
In-Reply-To: <FC2FB65B4D919844ADE4BE3C2BB739AD36CFDF94@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7533839782000726204==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 03/04/2011 12:53 AM, Xu, Martin wrote:
> Hi Denis:
> =

>>>  	struct ofono_gprs *gprs;
>>>  	struct ofono_gprs_context *gc;
>>>  	gboolean voice;
>>> +	gboolean online;
>>
>> I don't think you really need this one, you can use the presence of gprs
>> atom instead.
> Gprs atom is not reliable here. Because gprs will be flushed when enterin=
g offline mode

Both gprs and gprs-contexts will be flushed.  So you should be setting
them to NULL when going offline.  How is this not reliable?

>>
>> I suspect all you need to do is unref data->modem, set data->gc and
>> data->gprs to NULL in the offline callback prior to calling back into
>> the core.
> Logically, call back only needs to set offline states
> It is Huawei_disconnect's duty to decide the operation. =

> In theory, Huawei_disconnect may be called at any situation when io error=
 happens.
> (I observed two place, one is at ppp_disconnect the other is at offline m=
ode CFUN=3D5.)
> So the function must take action according to the states. =

> I will resent the updated patch

Sure, but what you're trying to prevent is keeping pointers around to
atoms which have gone away.  One easy way to do that would be to simply
set them to NULL when going offline.

You can also install atom watches, but that might not be worth the effort.

Regards,
-Denis

--===============7533839782000726204==--

