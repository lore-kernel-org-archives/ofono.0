Content-Type: multipart/mixed; boundary="===============1633346915058839146=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] atmodem: Detect usage of AT+CGEREP
Date: Tue, 25 Aug 2020 11:49:02 -0500
Message-ID: <e235d27e-8dd2-dc49-6f7c-3da2a8b81615@gmail.com>
In-Reply-To: <20200821083444.s43v6wf2tb2s7tlg@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1633346915058839146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

>> So in theory this could be written like:
>> int max =3D -1;
>> iter_open_list(&iter);
>>
>> while (iter_next_range(&iter, &max1, &max2)) {
>> 	if (max2 > max)
>> 		max =3D max2;
>> }
>>
>> iter_close_list(&iter);
> =

> I can do this and it does indeed work! :-)
> =

> This may be my personal thing, but I find this not very intuitive and
> hard to read.
> =

> To make this more intuitive can we:
> * move your proposed while loop to a new function
> * name that function ...iter_next_range_or_list (or something like that)
> * put that function into gatresult.c

I'm confused.  iter_next_range specifically handles ranges as defined by IT=
U =

v.250.  See section 5.7.3.1 "Range of Values".

Here's a small quote:
"If more than one value is supported, then the values may be listed =

individually, separated by comma characters (IA5 2/12), or, when a continuo=
us =

range of values is supported, by the first value in the range, followed by =
a =

hyphen character (IA5 2/13), followed by the last value in the range. The =

specification of single values and ranges of values may be intermixed withi=
n a =

single information text. In all cases, the supported values shall be indica=
ted =

in ascending order."

The only thing the user has to do is open up a list, since some modems get =
this =

wrong and don't enclose the entire set in '()'

> * and in the new at_cgerep_test_cb just use this function ?

How would you return the set of supported settings?  I guess you could use =

something like l_uintset, but even knowing the valid theoretical range is t=
ricky.

> =

> I can imagine this new function can be of use at other places as well.
> What do you think ?

Given my confusion above, no idea?

Regards,
-Denis
--===============1633346915058839146==--

