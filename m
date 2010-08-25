Content-Type: multipart/mixed; boundary="===============4794272592285108911=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: About ppp_receive()
Date: Wed, 25 Aug 2010 10:17:38 +0800
Message-ID: <33AB447FBD802F4E932063B962385B352A45BD92@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C747A25.4090707@neusoft.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4794272592285108911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Steven wrote:
> Hi Zhenhua,
> =

> Zhang, Zhenhua wrote:
>> Hi Steven,
>> =

>> Steven wrote:
>>> Hi Zhenhua
>>> =

>>> Zhang, Zhenhua wrote:
>>>> Hi Steven,
>>>> =

>>>> Steven wrote:
>>>>> Hi,
>>>>> =

>>>>> In function ppp_receive, we first check the protocol type of this
>>>>> frame like: =

>>>>> =

>>>>>   guint16 protocol =3D ppp_proto(buf);
>>>>> =

>>>>> and here we assumed the length of the protocol field is 16 bits,
>>>>> but in RFC 1661, the protocol field should be one or two octets.
>>>>> =

>>>>> "The Protocol field is one or two octets, and its value identifies
>>>>> the datagram encapsulated in the Information field of the packet."
>>>>> =

>>>>> why we given the assumption that protocol field is 16 bit length?
>>>> First I am not ppp expert. :-).
>>>> =

>>>> If you take look at pppd source code, main.c, get_input() also
>>>> always fetch two bytes 'protocol' for struct protent as well.
>>>> =

>>>> Can you give a case we failed in our ppp stack?
>>> If you interested in this topic, you can reference RFC 1661 Section
>>> 6.5,
>>> which said
>>> =

>>> --------------
>>> This Configuration Option provides a method to negotiate the
>>> compression of the PPP Protocol field. By default, all
>>> implementations MUST transmit packets with two octet PPP Protocol
>>> fields. PPP Protocol field numbers are chosen such that some values
>>> may be compressed into a single octet form which is clearly
>>> distinguishable from the two octet form. This Configuration
>>> Option is sent to inform the peer that the implementation can
>>> receive such single octet Protocol fields.
>>> -------------
>>> =

>>> In our current source code, because we only negotiate two
>>> configuration options - REQ_OPTION_MRU and REQ_OPTION_ACCM. so it's
>>> okey for our PPP stack.
>> =

>> Yes. It's handled in the LCP layer. The code is majorly implemented
>> by Kristen and Denis. Maybe they could have more comments on that. =

>> =

>>> But some carriers, like China Telecom or Sprint Network etc, will
>>> support the full configuration
>>> options(Magic-Number,Protocol-Field-Compression,Address-and-Control-Fie=
ld-Compression),
>>> So if PFC option is used ,our code will got wrong with
>>> ppp_receive(). =

>> =

>> Agree, we don't have pcompress, accompression like pppd yet. So
>> patches are welcome to improve that part. =

>> =

>> Btw, I do see some code related with MAGIC_NUMBER in ppp_lcp.c.
>> =

> =

> I will check it.
> =

>>> We should first check if PPP protocol field is compressed or not,
>>> and then get the right protocol value to form a 16 bits protocol
>>>   field, and pass this value to the rest functions.
>>> =

>>> Because of my company's security policy ,I can't provide a patch for
>>> this issue. But i can provide a method for doing this. Here it is.
>> =

>> I don't understand why having such policy at all. Your code
>> defintely won't leak any IP since we all follow with the standard
>> spec.  =

>> =

> =

> =

> In my company, i can't using git, usb or any other thing which contact
> with the outer world, but the only thing i can use to contact with the
> outer world is MY THUNDERBIRD!!!:(, It's a awful thing.
> =

> Maybe i can commit my patch when i go home:), if my son doesn't annoy
> me. =


Sure. Git is so powerful that you can definitely work any place you like to=
. You only need the network when you do 'git pull' and 'git send-email'. ;-)

>>> First byte of PPP protocol field may be compressed, if the LS bit
>>> is 1 then this indicates that the upper protocol us compressed,
>>> because the upper byte should be even, the lower byte should be odd.
>>> =

>>>>> In CDMA 2000 environment, just as the Sprint Network, PPP should
>>>>>   support a compressed protocol field. Is there anything
>>>>> difference between GSM and CDMA? =

>>>>> =

>>>>> B.R
>>>>> =

>>>>> Steven
>>> B.R
>>> =

>>> Steven
> =

> =

> -------------------------------------------------------------------------=
--------------------------
> Confidentiality Notice: The information contained in this e-mail and
> any accompanying attachment(s) is intended only for the use of the
> intended recipient and may be confidential and/or privileged of
> Neusoft Corporation, its subsidiaries and/or its affiliates. If any
> reader of this communication is not the intended recipient,
> unauthorized use, forwarding, printing,  storing, disclosure or
> copying is strictly prohibited, and may be unlawful.If you have
> received this communication in error,please immediately notify the
> sender by return e-mail, and delete the original message and all
> copies from your system. Thank you.
> -------------------------------------------------------------------------=
--------------------------
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


Regards,
Zhenhua

--===============4794272592285108911==--

