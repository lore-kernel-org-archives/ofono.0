Content-Type: multipart/mixed; boundary="===============3051170644344592303=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: Re: [PATCH] Add WSP_VALUE_TYPE_TEXT support in
 wsp_decode_application_id()
Date: Fri, 18 May 2012 14:59:31 +0200
Message-ID: <4FB647B3.8090906@linux.intel.com>
In-Reply-To: <4FB3D362.9080001@vfnet.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3051170644344592303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On 05/16/2012 06:18 PM, Jens Rehsack wrote:
> On 16.05.2012 17:45, Ronald Tessier wrote:
>> Hi Jens,
>
> Hi Ronald,
>
>> On 05/16/2012 04:03 PM, Jens Rehsack wrote:
>>> From: Jens Rehsack<sno@NetBSD.org>
>>>
>>> ---
>>>    src/wsputil.c |    6 ++++++
>>>    1 Datei ge=C3=A4ndert, 6 Zeilen hinzugef=C3=BCgt(+)
>>>
>>> diff --git a/src/wsputil.c b/src/wsputil.c
>>> index 1b2b2b7..c4c9d62 100644
>>> --- a/src/wsputil.c
>>> +++ b/src/wsputil.c
>>> @@ -496,6 +496,12 @@ gboolean wsp_decode_application_id(struct
>>> wsp_header_iter *iter,
>>>         */
>>>        if (wsp_header_iter_get_val_type(iter) =3D=3D WSP_VALUE_TYPE_SHO=
RT) {
>>>            val =3D *pdu_val&   0x7f;
>>> +    } else if (wsp_header_iter_get_val_type(iter) =3D=3D
>>> WSP_VALUE_TYPE_TEXT) {
>>> +        val_len =3D wsp_header_iter_get_val_len(iter);
>>> +        val =3D -1;
>>> +
>>> +        if (out_value)
>>> +            *out_value =3D pdu_val;
>>>        } else {
>>>            val_len =3D wsp_header_iter_get_val_len(iter);
>>>
>>
>> Unless I miss something, if the application_id is given as TEXT (in the
>> pdu) the *out_value will always be NULL (it will be set to the result of
>> get_text_entry()).
>>
>> I think you don't need to set val_len and val, you can just return TRUE
>> after doing *out_value =3D pdu_val.
>
> Probably. Do you want me to act on this and submit a new version (not
> before Monday - commuting now) or will you fix it on your own?
>

Indeed it can easily wait until Monday ...
Please, submit a new version of your patch to be reviewed by a maintainer.

Best regards,

Ronald

--===============3051170644344592303==--

