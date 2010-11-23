Content-Type: multipart/mixed; boundary="===============3395651050628323497=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [PATCH 0/3] Long dial string support (2nd)
Date: Tue, 23 Nov 2010 20:19:02 +0200
Message-ID: <4CEC0596.6030404@nokia.com>
In-Reply-To: <4CEBFCD4.80204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3395651050628323497==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/23/2010 07:41 PM, ext Denis Kenzior wrote:
> On 11/22/2010 10:36 AM, Andras Domokos wrote:
>    =

>> Dial strings can now be as long as 120 digits (not counting '+'). This f=
eature
>> is going to be needed by the FDN feature.
>>
>> An FDN may consist of a phone number plus a DTMF string. In order to hav=
e the
>> call succeed when FDN is enabled, both parts need to be provided when ma=
king a
>> call, as a single dial string.
>>      =

> So as mentioned previously, oFono does not support FDN.  So why are we
> doing this again?
>
>    =

Even if we don't support FDN at this point, there is still a remaining
related issue, who we are going to dial numbers like:

12345456p1234#1111

I think the the dial string could still be passed to the voicecall driver
that will take care of the modem specific details, most importantly
playing the DTMF tones and generating the tone events that would be
propagated back to voicecall manager and to D-Bus from there.
>> For AT modems the long dial string can be and has to be passed as is to =
the
>>      =

> Most AT modems have serious limitations on how many characters are
> supported in the dial string.  Not to mention that the pause character
> doesn't really always work.
>
> I can understand supporting long dialing numbers, but supporting dial
> strings is something else entirely...
>
> Regards,
> -Denis
>    =

Regards,
Andras


--===============3395651050628323497==--

