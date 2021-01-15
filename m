Content-Type: multipart/mixed; boundary="===============2086529660869134030=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: validate IMS private identity
Date: Fri, 15 Jan 2021 13:52:38 -0600
Message-ID: <5b0f5413-12b7-8472-74f7-3562c8165603@gmail.com>
In-Reply-To: <YAHrmTm8g3uptY8j@curiosity>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2086529660869134030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

>>> This field may not be defined for ISIM in use. In this case the
>>> field still can be read from ISIM, though it will not contain
>>> a valid UTF8 string. For instance, it may contain 255 0xFF bytes.
>>
>> Ugh, seems like the SIM vendor can't follow RFC's either?  31.103 Section
>> 4.2.2 says:
>>
>> "For contents and syntax of NAI TLV data object values see IETF RFC 2486
>> [24]. The NAI shall be encoded to an octet string according to UTF-8
>> encoding rules as specified in IETF RFC 3629 [27]. The tag value of the =
NAI
>> TLV data object shall be '80'. "
> =

> This crash occured during my experiments with eSIM. As I mentioned, the
> content of that TLV data object was 0xff bytes. IIUC it looks like vendor
> could just skip initialization of that particular TLV data object during
> bootstrap. Though I am not yet familiar with eSIM init procedure...
> =


I figured.  The likely reason for this is that SIM strings are generally en=
coded =

in another format.  If you're interested, see src/util.c sim_string_to_utf8=
(). =

0xff is used as padding in such cases and thus a field with only 0xffs is =

treated as empty.

However, the  above would seem not to apply to EFimpi and a few others that=
 3GPP =

wants encoded as a utf-8 string.  So, likely, a bug on the SIM, but we shou=
ld =

have sanitized the contents better.

Regards,
-Denis
--===============2086529660869134030==--

