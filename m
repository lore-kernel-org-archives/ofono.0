Content-Type: multipart/mixed; boundary="===============3340374654568121882=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] Core support for packet switched bearer reporting
Date: Mon, 10 Jan 2011 10:16:51 -0600
Message-ID: <4D2B30F3.40909@gmail.com>
In-Reply-To: <201101101319.53668.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3340374654568121882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

On 01/10/2011 05:19 AM, R=C3=A9mi Denis-Courmont wrote:
> On Friday 07 January 2011 18:25:32 ext Denis Kenzior, you wrote:
>>> @@ -2001,6 +2010,29 @@ void ofono_gprs_add_context(struct ofono_gprs
>>> *gprs,
>>>
>>>  	__ofono_atom_register(gc->atom, gprs_context_unregister);
>>>  =

>>>  }
>>>
>>> +void ofono_gprs_bearer_notify(struct ofono_gprs *gprs,
>>> +				unsigned int cid, int bearer)
>>> +{
>>> +	DBusConnection *conn =3D ofono_dbus_get_connection();
>>> +	GSList *l;
>>> +	const char *value =3D packet_bearer_to_string(bearer);
>>
>> Why bother running this operation before you're sure you're going to
>> emit the signal?
> =

> Now that we're talking about network-initiated LTE bearers, I would rathe=
r be =

> safe than sorry. I wouldn't assume that the modem will signal the CPSB =

> (unchanged) value later in this case.
> =


Are we both talking about the packet_bearer_to_string call?

>> Please move this down.
> =

> To avoid any race, we have to query the existing CPSB values after we ena=
ble =

> the CPSB subscription, right? We could surely move that to a later stage,=
 but =

> I don't see the benefit.
> =


What race?  I don't think you really read my comments...

Regards,
-Denis

--===============3340374654568121882==--

