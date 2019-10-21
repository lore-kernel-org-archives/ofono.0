Content-Type: multipart/mixed; boundary="===============2925541314481691623=="
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Subject: Re: Telit ME910C1-WW not detected
Date: Mon, 21 Oct 2019 13:45:03 +0100
Message-ID: <CABPh3UOuR8+47G4v1f910A_FCZ2qYk3By5O1nygbrQq1gxE7-g@mail.gmail.com>
In-Reply-To: <CAPS-YPCc_b5DV8_+uuY9U3GFLiZexiH9vyJpNzJQ64HosN8ACQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2925541314481691623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anibal,

Sorry but i was dragged along with other tasks and didn't test this througl=
y.
Next week I will be in the US (I am based in Ireland) to do some
testing on the reliability of ME910
and I will be able to thoroughly test this.
For now (from remote) it seems to be working fine but next week I will
have more information on this

Thanks for your patience
Nicola Lunghi

On Thu, 3 Oct 2019 at 23:09, Anibal Lim=C3=B3n <limon.anibal@gmail.com> w=
rote:
>
> Hi,
>
> I fix a bug in the code due to auto-attach, see [1] and the specific chan=
ge [2].
> Please test and let me know before send the patch.
>
> Cheers.
> Anibal
>
> [1] https://github.com/alimon/ofono/tree/me910_fix_v2
> [2] https://github.com/alimon/ofono/commit/682fd656afaf637b915d5d6b78a421=
1dd6e0884d
>
> On Wed, Oct 2, 2019 at 9:39 AM Anibal Lim=C3=B3n <limon.anibal@gmail.co=
m> wrote:
>>
>>
>>
>> On Wed, Oct 2, 2019 at 9:32 AM nick83ola <nick83ola@gmail.com> wrote:
>>>
>>> Thanks
>>>
>>> do you think that you can submit it to ofono mailing list?
>>>
>>> in particular I don;t know if
>>>
>>> if (data->model =3D=3D ME910C1)
>>> ofono_netreg_create(modem, OFONO_VENDOR_TELIT_ME910C1, "atmodem", data-=
>chat);
>>> else
>>> ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->chat);
>>
>>
>> That's because this specific model dosen't support  signal strength repo=
rting via CIND.
>>
>> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8ac1=
deeda5c#diff-2bbda16023120e26f58cfa7335520fb4
>>
>> Anibal
>>
>>>
>>>
>>> is acceptable
>>>
>>> Cheers
>>> Nicola Lunghi
>>>
>>>
>>> On Wed, 2 Oct 2019 at 15:29, Anibal Lim=C3=B3n <limon.anibal@gmail.co=
m> wrote:
>>>>
>>>>
>>>>
>>>> On Wed, Oct 2, 2019 at 9:00 AM nick83ola <nick83ola@gmail.com> wrote:
>>>>>
>>>>> Hi Anibal,
>>>>> I'm interested as well in the patch
>>>>>
>>>>> I saw that there you have two branches (me910 and v1.30+me910) can yo=
u tell me what branch have you tested?
>>>>> the diff is this
>>>>
>>>>
>>>> Yeah the latest one is me910, I was making a mistake to enable GPRS in=
stead of disable it, that's the change.
>>>>
>>>> Anibal
>>>>
>>>>>
>>>>>
>>>>> git diff me910
>>>>> diff --git a/plugins/telit.c b/plugins/telit.c
>>>>> index f36995dc..50344281 100644
>>>>> --- a/plugins/telit.c
>>>>> +++ b/plugins/telit.c
>>>>> @@ -239,16 +239,19 @@ static void cfun_enable_cb(gboolean ok, GAtResu=
lt *result, gpointer user_data)
>>>>>
>>>>>         ofono_modem_set_powered(modem, TRUE);
>>>>>
>>>>> -       /*
>>>>> -        * Tell the modem not to automatically initiate auto-attach
>>>>> -        * proceedures on its own.
>>>>> -        */
>>>>> -       if (data->model =3D=3D ME910C1)
>>>>> -               g_at_chat_send(data->chat, "AT+CGATT=3D0", NULL, NULL=
, NULL, NULL);
>>>>> -       else
>>>>> -
>>>>> +       if (data->model =3D=3D ME910C1) {
>>>>> +               /*
>>>>> +                * Telit ME910C1 needs to activate the GPRS to auto-a=
ttach the network.
>>>>> +                */
>>>>> +               g_at_chat_send(data->chat, "AT+CGATT=3D1", NULL, NULL=
, NULL, NULL);
>>>>> +       } else {
>>>>> +               /*
>>>>> +                * Tell the modem not to automatically initiate auto-=
attach
>>>>> +                * proceedures on its own.
>>>>> +                */
>>>>>                 g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_pre=
fix,
>>>>>                                         NULL, NULL, NULL);
>>>>> +       }
>>>>>
>>>>>         /* Follow sim state */
>>>>>         g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
>>>>>
>>>>>
>>>>> Thanks
>>>>> Nicola Lunghi
>>>>>
>>>>>
>>>>> On Tue, 1 Oct 2019 at 22:54, <limon.anibal@gmail.com> wrote:
>>>>>>
>>>>>> Hi Dresdo,
>>>>>>
>>>>>> I have a patch that adds support for Telit ME910 but it is upon Ofon=
o 1.30, i plan to send for review.
>>>>>>
>>>>>> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec=
8ac1deeda5c
>>>>>>
>>>>>> Regards!,
>>>>>> Anibal
>>>>>> _______________________________________________
>>>>>> ofono mailing list -- ofono(a)ofono.org
>>>>>> To unsubscribe send an email to ofono-leave(a)ofono.org
--===============2925541314481691623==--

