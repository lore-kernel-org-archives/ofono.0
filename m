Content-Type: multipart/mixed; boundary="===============3658723970564876758=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 11/19] stkutil: Add setup menu proactive command parser
Date: Wed, 12 May 2010 09:43:41 -0500
Message-ID: <201005120943.41761.denkenz@gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731DE14AD3@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3658723970564876758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> >There is no mention that the Alpha identifier can be present and empty, =
so
> >returning TRUE on a len 0 is not actually correct.  The only exception so
> > far seems to be text string which explicitly allows NULL strings.
> =

> Thus alpha_id seems to be another exception. For ber-tlv setup menu, alpha
>  identifier is mandatory, so sometimes we have to create an empty alpha id
>  object with len equals 0. See the case "set up menu 1.1.3" in 102.384
>  (page 333) for an example.

Ok fair enough. =


> This one is another exception. See the same case as above. I plan to check
>  all the mandatory dataobj and let len might equal to 0, how do you think
>  of?

My feeling right now is that if the test spec doesn't agree with the main s=
pec =

then let us accommodate the test spec in those circumstances only.

> >/* Parse only until item list */
> >parse_dataobj(iter, STK_DATA_OBJECT_TYPE_ALPHA_ID,
> >			DATAOBJ_FLAG_MANDATORY | DATAOBJ_FLAG_MINIMUM,
> >			&obj->alpha_id,
> >			STK_DATA_OBJECT_TYPE_ITEM,
> >			STK_DATA_OBJECT_TYPE_INVALID);
> >
> >/* Manually parse item list */
> >...
> >
> >/* Parse rest */
> >...
> =

> The second approach is hard to be implemented: We have moved
>  comprehension_tlv_iter_next() to parse_dataobj(), when manually parsing
>  item list, I have to get the next one to see if it's an item object. Then
>  we have to rollback one if the next is not an item dataobj. I like the
>  first approach (Actually it's similar to my solution ;)) and will send
>  patch based on this.
> =


You can always introduce comprehension_tlv_iter_save / restore type =

functionality if it makes things easier.  This is only applicable to two =

structures, so the first approach might be overkill.

Regards,
-Denis

--===============3658723970564876758==--

