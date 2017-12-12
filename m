Content-Type: multipart/mixed; boundary="===============3108921974223025001=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] voicecall: Support clir for last call dialing
Date: Mon, 11 Dec 2017 23:33:25 -0600
Message-ID: <87f6022c-7bd2-bc18-f008-49c1298ce953@gmail.com>
In-Reply-To: <CAPsFW+S0iZV41rfTambZ1KHfGkxgM5-DXPXQbi-q_mqD+01ZXg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3108921974223025001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>> This patch really needs to be broken up into 4.  See HACKING,
>> 'Submitting patches'.
> =

> Was not sure on how to handle this as four commits would have to be
> pushed together to avoid build breakage. But sure I can do this in 4
> commits if it turns out this patch makes sense (see the CLIR related
> stuff later)

Build breakage is minimized since I will take all the patches or not as =

a transaction, so the build should be clean on any given git pull.  It =

does make git bisect a bit trickier, but we don't use it often.

> =

>>> -static void hfp_dial_last(struct ofono_voicecall *vc,
>>> ofono_voicecall_cb_t cb,
>>> -			void *data)
>>> +static void hfp_dial_last(struct ofono_voicecall *vc, enum
>>> ofono_clir_option clir,
>>> +			ofono_voicecall_cb_t cb, void *data)
>>>    {
>>>    	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
>>>    	struct cb_data *cbd =3D cb_data_new(cb, data);
>>
>> It doesn't look like you actually implementing the CLIR modifier in the
>> driver?  E.g. the 'I' or 'i' suffix business.
>>
>> I think last time I played with this half the AG implementations didn't
>> support the CLIR parameter anyway.
> =

> Actually indeed I completely missed adding the CLIR modifier. Turns
> out the current dial method also doesn't. This got me digging. The

The Dial method was re-used for HFP from fully featured modems.  So it =

is present at the D-Bus API level, but the HFP driver simply ignores it. =

  I'm not sure that any AG implementations honor the 'I/i' modifier. =

Might be something to check first.

> Bluetooth spec for the HFP profile is rather ambigious if it is
> supported or not. Although from this:
> =

>   "As a convention, if a parameter of an AT command or result code is
> not =E2=80=9Ccovered=E2=80=9D in this
> specification, it shall not be present in the corresponding AT
> command, and the HF shall ignore the parameter whenever it is received
> in a result code." (page 83, section 4.33.2 in the HFP profile spec
> v1.7.1)
> =

> I gather it is not supported at all, however I wonder if it is useful
> to pass the parameter to possibly re-use this code elsewhere easier
> (similar to the dial function). Then again I have no idea if some of
> these things would be used in any other situations than with a
> Bluetooth/HFP AG. This then also impacts the other patch (where I need
> to fix the long int situation).

In the case of BLDN, you definitely won't have a CLIR modifier.  Since =

+BLDN is an extension command defined in HFP specification only and the =

syntax doesn't cover any modifiers.  In fact +BLDN takes no arguments if =

I recall correctly.  I would expect that besides HFP, nothing else will =

be using the DialLast API.

> =

> So what would be the best thing? Keep the parameter but not implement
> the CLIR for either of the options as it might/should not work? Or
> drop it and do without as we do not expect the methods to be used for
> anything else than HFP/Bluetooth?
> =


In theory memory dialing via ATD _could_ support CLIR =

invocation/suppression syntax.  Again I would expect that memory dialing =

only really makes sense on HFP.  With real hardware & a smartphone type =

UI, memory dialing is not needed.

So unless you really need this feature and at least one well known AG =

implementation (e.g. iOS or Android) actually supports this, I would not =

worry about adding support for the CLIR modifier.

Regards,
-Denis

> Thanks,
> =

> Philippe
> =



--===============3108921974223025001==--

