Content-Type: multipart/mixed; boundary="===============6934430632802730515=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: Re: [PATCH 1/7] voicecall: Support clir for last call dialing
Date: Mon, 11 Dec 2017 12:01:06 +0200
Message-ID: <CAPsFW+S0iZV41rfTambZ1KHfGkxgM5-DXPXQbi-q_mqD+01ZXg@mail.gmail.com>
In-Reply-To: <cd22972d-8465-d24e-9b63-85648446cce8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6934430632802730515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

Thank you for your review. You raised a number of good points for
things I missed or did not think about.

On 08/12/2017, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Philippe,
>
> On 12/06/2017 09:35 AM, Philippe De Swert wrote:
>> When dialing the last called number we also want to use the caller id
>> (clir)
>> settings that are currently used.
>>
>> ---
>>   doc/voicecallmanager-api.txt |  2 +-
>>   drivers/hfpmodem/voicecall.c |  4 ++--
>>   include/voicecall.h          |  3 ++-
>>   src/voicecall.c              | 18 ++++++++++++++----
>>   4 files changed, 19 insertions(+), 8 deletions(-)
>>
>
> This patch really needs to be broken up into 4.  See HACKING,
> 'Submitting patches'.

Was not sure on how to handle this as four commits would have to be
pushed together to avoid build breakage. But sure I can do this in 4
commits if it turns out this patch makes sense (see the CLIR related
stuff later)

>> -static void hfp_dial_last(struct ofono_voicecall *vc,
>> ofono_voicecall_cb_t cb,
>> -			void *data)
>> +static void hfp_dial_last(struct ofono_voicecall *vc, enum
>> ofono_clir_option clir,
>> +			ofono_voicecall_cb_t cb, void *data)
>>   {
>>   	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
>>   	struct cb_data *cbd =3D cb_data_new(cb, data);
>
> It doesn't look like you actually implementing the CLIR modifier in the
> driver?  E.g. the 'I' or 'i' suffix business.
>
> I think last time I played with this half the AG implementations didn't
> support the CLIR parameter anyway.

Actually indeed I completely missed adding the CLIR modifier. Turns
out the current dial method also doesn't. This got me digging. The
Bluetooth spec for the HFP profile is rather ambigious if it is
supported or not. Although from this:

 "As a convention, if a parameter of an AT command or result code is
not =E2=80=9Ccovered=E2=80=9D in this
specification, it shall not be present in the corresponding AT
command, and the HF shall ignore the parameter whenever it is received
in a result code." (page 83, section 4.33.2 in the HFP profile spec
v1.7.1)

I gather it is not supported at all, however I wonder if it is useful
to pass the parameter to possibly re-use this code elsewhere easier
(similar to the dial function). Then again I have no idea if some of
these things would be used in any other situations than with a
Bluetooth/HFP AG. This then also impacts the other patch (where I need
to fix the long int situation).

So what would be the best thing? Keep the parameter but not implement
the CLIR for either of the options as it might/should not work? Or
drop it and do without as we do not expect the methods to be used for
anything else than HFP/Bluetooth?

Thanks,

Philippe

--===============6934430632802730515==--

