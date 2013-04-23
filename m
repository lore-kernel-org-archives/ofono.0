Content-Type: multipart/mixed; boundary="===============2627767051357115273=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Tue, 23 Apr 2013 09:27:50 -0700
Message-ID: <AA25931D-D497-4625-981A-982E88AD96F2@holtmann.org>
In-Reply-To: <20130423161536.GA27409@x220>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2627767051357115273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johan,

>>>>> Even for outgoing pairing requests we may receive the UUIDs property
>>>>> changed after the device is paired and try to register it twice.
>>>>> =

>>>>> The easiest way to reproduce this is when Extended Inquiry Response is
>>>>> supported.
>>>>> =

>>>>> When the device is paired, we receive the "Paired" PropertyChanged,
>>>>> inside modem_register_from_proxy(), g_dbus_proxy_get_property() gets
>>>>> the UUIDs extracted from the EIR data.  Later, when the service
>>>>> discovery is finished, the UUIDs property is re-sent and both may
>>>>> contain the HFP AG UUID.
>>>> =

>>>> My sources indicated to me that BlueZ should perform the SDP query
>>>> first, and then signal Paired.  Is this something we can not count
>>>> on or is this an implementation issue inside BlueZ itself?
>>> =

>>> BlueZ has always done pairing first and only then SDP. This is because
>>> there are security mode 3 devices out there that do not permit any kind
>>> of connection before pairing has been completed (i.e. even if we wanted
>>> to do SDP first we can't with them). That said, we do at least delay the
>>> NewConnection() callback until SDP has been completed.
>> =

>> so when are we sending "Paired" property? We might have to delay that
>> property update until SDP finished.
> =

> Right now it's directly bound to when the device is actually paired,
> i.e. ignoring any other ongoing operations such as SDP.
> =

>> We have to make sure that we finished SDP after the pairing before
>> updating any clients with property changes.
> =

> I don't completely understand the rationale of wanting to make BlueZ's
> clients so fragile. You could in theory get new services way after
> pairing if this is configurable on the remote side. You could also get
> the result of calling Device1.Connect() instead of Device1.Pair() in
> BlueZ.
> =

> On the other hand, we do delay the response to Device1.Pair() until SDP
> is complete so delaying the Paired property would in a way be consistent
> with that. I'll look into how simple this would be. We already track the
> completion of SDP for each device internally with a svc_resolved boolean
> so probably a new flag to indicate that "Paired" still needs to be
> emitted should be all the extra context tracking we need.

the pairing procedure is special and we should try to avoid any pointless r=
ound trips or wake ups for the clients here. We do know that we are running=
 SDP after pairing anyway. So lets just wait for it to finish. Especially i=
f we do that already anyway for Device1.Pair().

Regards

Marcel


--===============2627767051357115273==--

