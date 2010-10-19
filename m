Content-Type: multipart/mixed; boundary="===============6137726153363700317=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/13] voicecall: __ofono_voicecall_send_tone internal api.
Date: Tue, 19 Oct 2010 16:10:58 +0200
Message-ID: <AANLkTimx4b7OR0wqzHv-J7wfbP5JN2m2RL71cVNbe6o8@mail.gmail.com>
In-Reply-To: <4CB6C3A1.3090508@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6137726153363700317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

sorry for responding late.

On 14 October 2010 10:47, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/13/2010 08:54 AM, Andrzej Zaborowski wrote:
>> This provides a way for other atoms to send DTMF tones during a call.
>> ---
>> =C2=A0src/ofono.h =C2=A0 =C2=A0 | =C2=A0 =C2=A04 ++++
>> =C2=A0src/voicecall.c | =C2=A0 16 ++++++++++++++++
>> =C2=A02 files changed, 20 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/ofono.h b/src/ofono.h
>> index 6c7f649..6efd9ac 100644
>> --- a/src/ofono.h
>> +++ b/src/ofono.h
>> @@ -218,6 +218,10 @@ int __ofono_voicecall_dial(struct ofono_voicecall *=
vc,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_voicecall_dial_cb_t cb, void *user=
_data);
>> =C2=A0void __ofono_voicecall_dial_cancel(struct ofono_voicecall *vc);
>>
>> +int __ofono_voicecall_send_tone(struct ofono_voicecall *vc,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *tone_str,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_voicecall_cb_t cb, void *user_data);
>> +
>
> So this one is structured according to __ofono_voicecall_dial, should we
> also have __ofono_voicecall_send_tone_cancel?
>
>> =C2=A0#include <ofono/sms.h>
>>
>> =C2=A0struct sms;
>> diff --git a/src/voicecall.c b/src/voicecall.c
>> index 7b5fe3b..45e19ce 100644
>> --- a/src/voicecall.c
>> +++ b/src/voicecall.c
>> @@ -2326,3 +2326,19 @@ void __ofono_voicecall_dial_cancel(struct ofono_v=
oicecall *vc)
>>
>> =C2=A0 =C2=A0 =C2=A0 vc->dial_req->cb =3D NULL;
>> =C2=A0}
>> +
>> +int __ofono_voicecall_send_tone(struct ofono_voicecall *vc,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *tone_str,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ofono_voicecall_cb_t cb, void *user_data)
>> +{
>> + =C2=A0 =C2=A0 if (!vc->driver->send_tones)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOSYS;
>> +
>> + =C2=A0 =C2=A0 /* Send DTMFs only if we have at least one connected cal=
l */
>> + =C2=A0 =C2=A0 if (!voicecalls_can_dtmf(vc))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOENT;
>
> I'm a bit worried that we never check for BUSY conditions here, in
> particular since we can get into this situation:
>
> Send DTMF
> Cancel
> Send DTMF
>
> Which results in two DTMF operations being outstanding.
>
>> +
>> + =C2=A0 =C2=A0 vc->driver->send_tones(vc, tone_str, cb, user_data);
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>
> We also don't busy out any D-Bus operations when Send DTMF is in progress=
...

So I gave this some thought now and made an implementation based on
the __ofono_voicecall_dial api, but I think that this old approach is
actually working better for us.  There are a couple of scenarios
(let's consider only atmodem first)

1. Send DTMF - Cancel - Send DTMF

in this case the second Send DTMF is going to return an error from the
driver (not from core voicecall.c).  I don't think it's a big deal,
but we could think of something like cancelling the driver .send_tones
call, because the operation can potentially take a while -- this would
need a little change in the driver api.

2. Send DTMF - DBus command arrives,

Now any DBus command (other than SendTone) will actually be sent to
the driver and executed.  I think that's the correct thing to do --
the user needs to be able to end the call at any time.  The tones
being emitted should not actually interfere with anything.  The only
thing we need to do is respond to the STK command with an error if the
call is terminated before all tones finished being emitted.

3. Modem is doing something and a Send DTMF stk command arrives,

In this case the DTMFs will be delayed because of command
serialisation in gatchat / gisi.  Should we return "terminal busy" to
the card instead?

What do you think?  What behaviour do we want?

The handling may be different in case of isimodem, so this would need
checking anyway.

Best regards

--===============6137726153363700317==--

