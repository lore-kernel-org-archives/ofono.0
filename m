Content-Type: multipart/mixed; boundary="===============6155548706247257227=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 2/4] emulator: add routine to request/release private
 network from ConnMan
Date: Fri, 29 Apr 2011 03:59:45 -0500
Message-ID: <4DBA7E01.6070304@gmail.com>
In-Reply-To: <4DBA8D9C.2000106@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6155548706247257227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>>> struct emulator_network_provision_driver{
>>>      char *name;
>>>      (void)(*get_settings)(struct emulator_network **out_en);
>> You will probably need to make this async, and allow cancellation, since
>> there can be multiple emulators requesting private networks
>> concurrently.  This probably means you need to return a unique
>> identifier as well.
>>
> =

> Concerning asynchronism and cancellation,
> I don't see the use case here, do you mean:
>     - on a device with multiple modems, we have one DUN emulator per modem
>     - 2 clients request DUN data call on this device, data call will be
> redirected to each modem by ConnMan.
>     - oFono will ask for 2 private network settings, however ConnMan

You can have several modems in the system with DUN connections.  You
might have several DUN connection transports active, e.g. USB & BT, or
you might simply have several clients on the same transport.

> can't handle this case, so we should
>       avoid this case from oFono by cancelling the 1 of the request.
> =


Is ConnMan only handing out 1 IP per application?  If so that is not
enough for oFono...

> how should we priotirize it?
> Could that be a concrete use case?
> =

>>>      (void)(*release)(void);
>> And you need to take the unique id as input here.
> =

> I can store the private_network_settings into ofono_emulator. Then I
> pass it as input of the release function.
> =


Won't work as you might need to cancel a request that is still pending.

Regards,
-Denis

--===============6155548706247257227==--

