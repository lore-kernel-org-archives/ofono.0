Content-Type: multipart/mixed; boundary="===============2716423799482810769=="
MIME-Version: 1.0
From: Simon Fels <simon.fels@canonical.com>
Subject: Re: [PATCH 07/10] ril: Remove asserts
Date: Tue, 20 Oct 2015 10:28:44 +0200
Message-ID: <5625FB3C.10307@canonical.com>
In-Reply-To: <CACM4vuD4e9bpbaDNbp=vmuRpoKHtcf5VJv=HP1Hf7-A5LQfL7A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2716423799482810769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 20.10.2015 09:26, Alfonso Sanchez-Beato wrote:
> On Mon, Oct 19, 2015 at 3:55 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>
>> Hi Alfonso,
>>
>> On 10/15/2015 11:47 AM, Alfonso Sanchez-Beato wrote:
>>
>>> ---
>>>    plugins/ril.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/plugins/ril.c b/plugins/ril.c
>>> index e31f24b..2edb0a9 100644
>>> --- a/plugins/ril.c
>>> +++ b/plugins/ril.c
>>> @@ -144,7 +144,9 @@ static void ril_radio_state_changed(struct ril_msg
>>> *message, gpointer user_data)
>>>                          break;
>>>                  default:
>>>                          /* Malformed parcel; no radio state =3D=3D bro=
ken
>>> rild */
>>> -                       g_assert(FALSE);
>>> +                       ofono_error("%s: Bad radio state (%d), exiting",
>>> +                                                       __func__,
>>> radio_state);
>>> +                       exit(1);
>>>
>>
>> Can we just remove the ril modem in question instead of killing the enti=
re
>> daemon?
>
>
> I think that if we start to do these things we need to add modem watches =
to
> udev/udevng/rildev as they keep lists with the modems and remove them in
> shutdown. Maybe we could try a modem reset here, within a limited number =
of
> retries instead?

We should avoid exiting in any case. The minimum we can do is to bring =

the whole modem down if we can't do anything more so we end up in the =

same state as we would when restarting ofono and we're about to setup =

the rilmodem again.

regards,
Simon


--===============2716423799482810769==--

