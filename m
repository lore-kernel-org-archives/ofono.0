Content-Type: multipart/mixed; boundary="===============5097821850455710146=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] atmodem: Detect usage of AT+CGEREP
Date: Thu, 20 Aug 2020 09:41:28 -0500
Message-ID: <45c4a468-df10-ff48-8ec3-36291c3bd33f@gmail.com>
In-Reply-To: <20200820120007.v4tjzni73mg5gtba@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5097821850455710146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

>> So why not just run iter_next_range in a loop?  it actually understands =
both
>> lists and ranges.  See cind_support_cb() for an example.
> =

> Ok, I can do this i a loop if you want.
> =

>>> +	/* if min1 =3D=3D max1 we had no range but a list and that
>>> +	 * means we are interested in the last number of that list*/
>>> +	if (min1 =3D=3D max1) {
>>> +		while (!g_at_result_iter_close_list(&iter)) {
>>> +			if (!g_at_result_iter_next_number(&iter, &max1))
>>> +				break;
>>> +		}
>>> +	}
>>> +
>>> +	if (!g_at_result_iter_skip_next(&iter)) {
>>> +		two_arguments =3D false;
>>> +		goto out;
>>> +	}
>>
>> Not sure what this is doing?  isn't +CGEREP just two lists ?  According =
to 27.007:
>> "+CGEREP:=C2=A0(list of supported <mode>s),(list of supported <bfr>s)"
> =

> Well, we have to deal with very different +CGEREP results. For example
> on the quectel EC21 I get this:
> =

> "+CGEREP: (0-2),(0,1)"
> =

> and on the quectel M95 I get this:
> =

> "+CGEREP: (0,1)"
> =

> So what the code does is this:
> It tries to parse a range with
> =

> g_at_result_iter_next_range(&iter, &min1, &max1)
> =

> Now two things can happen: It either parsed the range "(0-2)" then we
> have min1 !=3D max1, or it tried to parse a list "(0,1)". This time
> iter_next_range() breaks on the comma ',' and exits with
> min1 =3D=3D max1 =3D=3D 0. Then we know, we did not find the maximum valu=
e yet
> and we enter the loop:
> =

> =E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7w=
hile (!g_at_result_iter_close_list(&iter)) {
> =E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=
=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7if (!g_at_result_iter_ne=
xt_number(&iter, &max1))
> =E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=
=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=
=B7=C2=B7=C2=B7=C2=B7=C2=B7break;
> =E2=96=B8=C2=B7=C2=B7=E2=96=B8=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7}
> =

> This does then loop to the end of the list until iter_close_list()
> becomes true, which is at the closing paranthesis ')'. max1 then
> contains the last item in that list (which we suspect to be the
> maximum value).

So in theory this could be written like:
int max =3D -1;
iter_open_list(&iter);

while (iter_next_range(&iter, &max1, &max2)) {
	if (max2 > max)
		max =3D max2;
}

iter_close_list(&iter);

> =

> Now we have min1 and max1 in both cases(list and range). Now if
> =

> g_at_result_iter_skip_next()
> =

> fails, we are at the end of the AT result and we had only one argument
> to +CGEREP or we start trying to parse the second argument also. (See
> below.)
> =

> At the end we construct our AT+CGEREP=3D string depending on if we had
> two or only one argument.

or you could take the above code I suggested followed by something like:

if (!iter_open_list(&iter)) {
	twoargs =3D false;
	goto done;
}

while (iter_next_range(...)) {
...
}

iter_close_list(&iter);

...

Regards,
-Denis
--===============5097821850455710146==--

