Content-Type: multipart/mixed; boundary="===============0577807726646108905=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH] atmodem: Do some polling on at_pin_query
Date: Tue, 17 Apr 2012 09:52:04 +0200
Message-ID: <4F8D2124.1040508@linux.intel.com>
In-Reply-To: <4F8C299B.1030105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0577807726646108905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 16/04/2012 16:15, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 04/16/2012 03:06 AM, Guillaume Zajac wrote:
>> Hi Denis,
>>
>> On 12/04/2012 21:36, Denis Kenzior wrote:
>>> Hi Guillaume,
>>>
>>> On 04/12/2012 09:28 AM, Guillaume Zajac wrote:
>>>> For some modem like ZTE MF180/190, we need to do some
>>>> polling to check SIM state when it returns +CME ERROR: 14 busy.
>>>> ---
>>>>    drivers/atmodem/sim.c |   59
>>>> +++++++++++++++++++++++++++++++++++++++---------
>>>>    1 files changed, 48 insertions(+), 11 deletions(-)
>>>>
>>> <snip>
>>>
>>>> @@ -874,9 +878,22 @@ static void at_cpin_cb(gboolean ok, GAtResult
>>>> *result, gpointer user_data)
>>>>        else
>>>>            decode_at_error(&error, final);
>>>>
>>>> -    if (!ok) {
>>>> +    switch (error.type) {
>>>> +    case OFONO_ERROR_TYPE_NO_ERROR:
>>>> +        break;
>>>> +    case OFONO_ERROR_TYPE_CME:
>>>> +        /* Check for SIM busy - try again later */
>>>> +        if (error.error =3D=3D 14) {
>>>> +            if (sd->poll_count++<   12) {
>>>> +                sd->poll_source =3D g_timeout_add_seconds(2,
>>>> +                        sim_state_check, cbd);
>>>> +                return;
>>>> +            }
>>>> +        }
>>>> +        /* fall through */
>>>> +    default:
>>>>            cb(&error, -1, cbd->data);
>>>> -        return;
>>>> +        goto done;
>>>>        }
>>>>
>>>>        if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM) {
>>> Is there a reason we are not using at_util_sim_state_query_new?
>> This function is only giving sim present information through its
>> callback, however I also need to parse the answer from AT+CPIN?
>> So it means we would send once the AT+CPIN? using atutil helper and once
>> to parse the answer.
>> I thought about implementing a new atutil helper function or a new
>> g_at_chat_send_recursive() function but I saw in
>> drivers/atmodem/phonebook.c on AT+CPBS=3D? command that polling mechanism
>> is integrated into the driver itself.
>> That's why I have chosen this solution.
>>
> Then I'm a bit lost what you're trying to solve.  The ZTE modem driver
> is already running CPIN query repeatedly to figure out the SIM state.
> So the only reason why we might be receiving a CME ERROR 14 is if we
> (successfully) entered the PIN but the modem is busy initializing the
> SIM.  In this case polling until CPIN becomes ready from within
> at_pin_send_cb seems good enough.  Or is there something I am missing

According to our discussion on IRC, I will send a v2 for which the =

polling is done after PIN is entered.

Kind regards,
Guillaume

--===============0577807726646108905==--

