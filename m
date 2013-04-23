Content-Type: multipart/mixed; boundary="===============0875678926487990263=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] hfp_hf_bluez5: Fix re-registering a modem for a device
Date: Tue, 23 Apr 2013 08:34:05 -0700
Message-ID: <AF9D10A5-D958-4E8A-9B41-1EA0A5C9BD92@holtmann.org>
In-Reply-To: <20130423152354.GA25876@x220>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0875678926487990263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johan,

>>> Even for outgoing pairing requests we may receive the UUIDs property
>>> changed after the device is paired and try to register it twice.
>>> =

>>> The easiest way to reproduce this is when Extended Inquiry Response is
>>> supported.
>>> =

>>> When the device is paired, we receive the "Paired" PropertyChanged,
>>> inside modem_register_from_proxy(), g_dbus_proxy_get_property() gets
>>> the UUIDs extracted from the EIR data.  Later, when the service
>>> discovery is finished, the UUIDs property is re-sent and both may
>>> contain the HFP AG UUID.
>> =

>> My sources indicated to me that BlueZ should perform the SDP query
>> first, and then signal Paired.  Is this something we can not count
>> on or is this an implementation issue inside BlueZ itself?
> =

> BlueZ has always done pairing first and only then SDP. This is because
> there are security mode 3 devices out there that do not permit any kind
> of connection before pairing has been completed (i.e. even if we wanted
> to do SDP first we can't with them). That said, we do at least delay the
> NewConnection() callback until SDP has been completed.

so when are we sending "Paired" property? We might have to delay that prope=
rty update until SDP finished.

We have to make sure that we finished SDP after the pairing before updating=
 any clients with property changes.

Regards

Marcel


--===============0875678926487990263==--

