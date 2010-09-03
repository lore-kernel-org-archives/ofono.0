Content-Type: multipart/mixed; boundary="===============6991329932211834703=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Patch: "Added missing DCS handling in stkutil and stk" Description
Date: Fri, 03 Sep 2010 16:10:40 -0500
Message-ID: <4C816450.4020907@gmail.com>
In-Reply-To: <AANLkTikRo0aM549pBa5G=Muh8oQUcTZc5KQM82G0Yq1o@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6991329932211834703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/02/2010 08:59 PM, Jeevaka Prabu Badrappan wrote:
> Hi Andrzej,
> =

>> There are two cases:
>>  * Get Inkey/Get Input, where the answer is actual text, in this case
>> the dcs can be determined automatically,
>>
>>  * Send USSD where we're sending the "8.15 Text string" but the
>> contents don't actually have to contain a string, it may be any data
>> that the network sends us.  So to me it makes more sense to handle
>> this using a separate structure like you did in your original patch,
>> which contains len, dcs and contents.
> =

> Yes, I undestand for the Get Inkey/Get Input, dcs is determined
> automatically. Currently, we are providing one function for building
> each data object specificed in 3GPP specification. If we provide a new
> structure, then we need to provide a new function for building the
> text string data object. This will result in having 2
> build_dataobj_text( existing one for handling Get Inkey and Get Input)
> and build_dataobj_ussdtext(new one for handling the section 8.15),

I agree with Andrew completely here.

In effect your modifications to build_dataobj_text are doing this
anyway.  You're also forcing the Display Text, Get Input, Get Inkey, etc
objects to care about details of USSD, which they really shouldn't.  The
code will be much simpler to follow if we use a different structure for
this particular case.

> which is deviating from the existing ones. If we extend the existing
> structure and add generalised handling which is done now in this
> patch, we won't be deviating from the existing things.

Actually the spec is deviating from the intended purpose of the Text
data object (which should contain Text), so handling it specifically is
actually better.

Regards,
-Denis

--===============6991329932211834703==--

