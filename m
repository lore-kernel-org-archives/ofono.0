Content-Type: multipart/mixed; boundary="===============3419856836990970076=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] stkutil: Complete the TLV parsing/builder to support
 BIP commands
Date: Fri, 25 Mar 2011 12:15:31 -0500
Message-ID: <4D8CCDB3.6040206@gmail.com>
In-Reply-To: <4D8CC805.30205@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3419856836990970076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

<snip>

> Indeed the size to be returned in the Terminal response is encoded with
> one byte (reason why you can find an unsigned char in the structures
> stk_response_receive_data and stk_response_send_data).
> I understand also the logic that fills the Data Length structure:
>     stk_tlv_builder_append_byte(tlv, MIN(*length, 255))
> =

> but I really need to store the real number of bytes remaining/available,
> and this number can exceed 255. So, I would like to keep this data type
> or at least go for an unsigned short.
> =

>

Then go with unsigned short for now and I'll try to pay attention as to
why you think you need this on my next review.

> =

> Regarding the modifications I did in the enum section/structures, you
> wrote:
> =

>>Can you do me a favor and add the Section # for the enums / structs
>>you're modifying / introducing where needed.  We were supposed to be
>>doing this but somehow were not consistent enough over time.
> =

> Could you clarify with an example ?

Just have a look at stkutil.h, there are plenty of examples.

e.g.

/*
 * TS 101.220, Section 7.2, Card Application Toolkit assigned templates,
 * These are the same as 3GPP 11.14 Sections 13.1 and 13.2
 */
enum stk_envelope_type {

or

/* TS 102.223 Section 9.4 */
enum stk_command_type {

Regards,
-Denis

--===============3419856836990970076==--

