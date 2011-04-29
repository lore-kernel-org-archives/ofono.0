Content-Type: multipart/mixed; boundary="===============1749792292963114258=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2 2/4] emulator: add routine to request/release private
 network from ConnMan
Date: Fri, 29 Apr 2011 16:35:31 +0200
Message-ID: <4DBACCB3.2090107@linux.intel.com>
In-Reply-To: <4DBA7E01.6070304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1749792292963114258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 29/04/2011 10:59, Denis Kenzior wrote:
> Hi Guillaume,
>
>>>> struct emulator_network_provision_driver{
>>>>       char *name;
>>>>       (void)(*get_settings)(struct emulator_network **out_en);
>>> You will probably need to make this async, and allow cancellation, since
>>> there can be multiple emulators requesting private networks
>>> concurrently.  This probably means you need to return a unique
>>> identifier as well.
>>>
>> Concerning asynchronism and cancellation,
>> I don't see the use case here, do you mean:
>>      - on a device with multiple modems, we have one DUN emulator per mo=
dem
>>      - 2 clients request DUN data call on this device, data call will be
>> redirected to each modem by ConnMan.
>>      - oFono will ask for 2 private network settings, however ConnMan
> You can have several modems in the system with DUN connections.  You
> might have several DUN connection transports active, e.g. USB&  BT, or
> you might simply have several clients on the same transport.
>

Ok

>> can't handle this case, so we should
>>        avoid this case from oFono by cancelling the 1 of the request.
>>
> Is ConnMan only handing out 1 IP per application?  If so that is not
> enough for oFono...
>

This is the case in current private network implementation.
I guess it can be changed.

>> how should we priotirize it?
>> Could that be a concrete use case?
>>
>>>>       (void)(*release)(void);
>>> And you need to take the unique id as input here.
>> I can store the private_network_settings into ofono_emulator. Then I
>> pass it as input of the release function.
>>
> Won't work as you might need to cancel a request that is still pending.

OK I will try to fix this.


Kind regards,
Guillaume

--===============1749792292963114258==--

