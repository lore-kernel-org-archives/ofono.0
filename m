Content-Type: multipart/mixed; boundary="===============6041732053305135113=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v2 2/4] emulator: add routine to request/release private
 network from ConnMan
Date: Fri, 29 Apr 2011 12:06:20 +0200
Message-ID: <4DBA8D9C.2000106@linux.intel.com>
In-Reply-To: <4DB9C266.4020605@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6041732053305135113==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 28/04/2011 21:39, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 04/28/2011 08:29 AM, Guillaume Zajac wrote:
>> Hi Denis,
>>
>> On 27/04/2011 05:25, Denis Kenzior wrote:
>>> Hi Guillaume,
>>>
>>> On 04/22/2011 07:06 AM, Guillaume Zajac wrote:
>>>> +typedef void (*network_request)(struct ofono_error *, int *,
>>>> +                const char **, const char **,
>>>> +                const char **, const char **);
>>>> +typedef void (*network_release)(void);
>>>> +
>>>> +void ofono_emulator_add_network_request_cb(struct ofono_emulator *em,
>>>> +                            network_request cb);
>>>> +void ofono_emulator_add_network_release_cb(struct ofono_emulator *em,
>>>> +                            network_release cb);
>>>> +
>>> I really don't like this, you're re-inventing the wheel here.  We
>>> already solved this pattern a while ago ;)  I suggest you look at
>>> include/gprs-provision.h and examples/provision.c
>> In looking the example, I should create some emulator network drivers to
>> get settings and release the network like:
>>
>> struct emulator_network{
>>      ...
>> }
> struct private_network_settings or something might be better
>

Ok

>> struct emulator_network_provision_driver{
>>      char *name;
>>      (void)(*get_settings)(struct emulator_network **out_en);
> You will probably need to make this async, and allow cancellation, since
> there can be multiple emulators requesting private networks
> concurrently.  This probably means you need to return a unique
> identifier as well.
>

Concerning asynchronism and cancellation,
I don't see the use case here, do you mean:
     - on a device with multiple modems, we have one DUN emulator per modem
     - 2 clients request DUN data call on this device, data call will be =

redirected to each modem by ConnMan.
     - oFono will ask for 2 private network settings, however ConnMan =

can't handle this case, so we should
       avoid this case from oFono by cancelling the 1 of the request.

how should we priotirize it?
Could that be a concrete use case?

>>      (void)(*release)(void);
> And you need to take the unique id as input here.

I can store the private_network_settings into ofono_emulator. Then I =

pass it as input of the release function.

>> }
>>
>> and un/register drivers into emulator.c
>>
>>> Regards,
>>> -Denis
>>>
>> Kind regards,
>> Guillaume
> Regards,
> -Denis
>

Kind regards,
Guillaume


--===============6041732053305135113==--

