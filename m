Content-Type: multipart/mixed; boundary="===============3678706006530238469=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: gatchat looses UR code if received while waiting a response
Date: Mon, 21 Feb 2011 09:14:25 -0600
Message-ID: <4D628151.4040008@gmail.com>
In-Reply-To: <1298286070.18611.86.camel@lkunnasl-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3678706006530238469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

On 02/21/2011 05:01 AM, Lasse Kunnasluoto wrote:
> Hi Marcel,
> =

> On Mon, 2011-02-21 at 12:04 +0200, Marcel Holtmann wrote:
>> Hi Lasse,
>>
>>> I've seen an issue in Unsolicited Result code handling in gatchat. If
>>> ofono has sent an AT command and is waiting for a response, but modem
>>> has sent an UR code just before the AT command reached the modem,
>>> gatchat does not handle that UR code correctly (it drops it). =

>>>
>>> 27.007 does not restrict UR-sending in the time between AT command and
>>> sending final response.
>>>
>>> Even modem would not send an UR while an active AT command, this may
>>> happen as a command may be on its way to ofono (e.g. in kernel).
>>
>> actually GAtChat handles this correctly. Important is what you give as
>> valid_resp to g_at_chat_send. If this is NULL, then all lines between
>> the command and OK are consumed by the callback of the send command.
>>
> agree, but it would require a quite effort to change all the NULLs to
> something meaningful + test with various modems.
> =


You should not be passing NULL in the first place.  The reason CGMM does
so is that it has no prefix in the spec (a hold over from V.250).  So if
you have not been using proper prefixes, I'm afraid you have to fix them
properly.  The spec mandates the prefixes to expect, so this shouldn't
be so hard anyway.

>>> Real example of this happening:
>>> ofonod[1388]: Default: > AT+CGMM\r                  =

>>> ofonod[1388]: Default: < \r
>>> \n*STKI:"D027810301258082028182850A5361756E616C616874698F09013E50726570=
6169641801241F020103"\r\n =

>>> ofonod[1388]: Default: < \r\nST-Ericsson Mobile Broadband\r\n\r\nOK\r
>>> \n  =

>>>
>>> In this case the call back of *STKI was never called.
>>>
>>> This is not a modem issue as it has been verified the modem has sent
>>> *STKI before AT+CGMM was received.
>>
>> I consider this a modem issue. It should not send *STKI during a AT+CGMM
>> command to avoid any kind of confusion of the parser.
>>
> This specific case is not a modem issue. Modem has not received AT+CGMM
> when it sent *STKI (This was verified from modem logs). Modem cannot
> predict that there is AT+CGMM coming. Command was sent exactly same time
> on modem and ofono side. =

> =

> This is timing depend issue and in my opinion may occur with any AT
> modem. Ofono and Modem states are not always the same as there is
> certain delay when commands are exchanged between ofono and modem. These
> issues may be hidden most of the time but may cause some nasty errors
> some day.
> =


Sounds like the read watch priority should be higher than the write
watch priority to avoid this specific example.  Care to send a patch?

>>> One way to solve this is to change the sequence in gatchat.c/have_line()
>>> a bit and check first if this is UR code and then proceeding to response
>>> handling. Would this be acceptable solution for this issue or would it
>>> cause some drawbacks? If it is okay I can submit a patch
>>
>> See my command above. GAtChat is operating just fine.
>>
> More robust solution would be to change GAtChat than defining and
> finding valid_resps for tens or hundreds of AT commands. I want to point
> out that this is not only an issue with CGMM but may occur with any AT
> command when the timing matches.
> =


There's nothing you can do in GAtChat at this point.  Having the
unsolicited response handler fire and consume lines before the pending
AT command handler won't work either.  If you're not convinced, try
handling solicited / unsolicited CREG/CGREG and friends.

Regards,
-Denis

--===============3678706006530238469==--

