Content-Type: multipart/mixed; boundary="===============0480996622267903827=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: AT commands not being parsed correctly from Samsung Wave HFP
Date: Fri, 07 Oct 2011 12:57:17 +0200
Message-ID: <4E8EDB0D.9020304@bmw-carit.de>
In-Reply-To: <4E8DED34.5030906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0480996622267903827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 10/06/2011 08:02 PM, Denis Kenzior wrote:
> Hi Mikel,
>
>> ofonod[12078]:>  AT+CLCC\r
>> ofonod[12078]:<  \r\n\r\nOK\r\n\r\n
>>
>>
> There is an extra set of \r\n at the end of the OK and the gsmv1 syntax
> parser used by the hfp_hf plugin is quite strict.
>
>> It seems that, after the last line, no other AT commands are parsed
>> correctly. Any ideas of what's wrong?
> Try using the permissive syntax parser.
>
> Regards,
> -Denis

Right, the permissive one works perfectly. The phone has passed all our =

tests.

Now the next question is whether it would make sense to switch the HFP =

plugin to this parser, or this would rather be done selectively.

Which would be the drawbacks of using the permissive parser for all phones?

Regards,
Mikel


--===============0480996622267903827==--

