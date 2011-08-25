Content-Type: multipart/mixed; boundary="===============4311418921880107777=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: Bluetooth HF role
Date: Thu, 25 Aug 2011 14:32:50 +0200
Message-ID: <4E5640F2.5010302@bmw-carit.de>
In-Reply-To: <4E4F7797.7060905@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4311418921880107777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 08/20/2011 11:00 AM, Denis Kenzior wrote:
> Hi Mikel,
>
> On 08/24/2011 10:28 AM, Mikel Astiz wrote:
>> Hi all,
>>
>> I'm trying to understand the features currently supported by oFono
>> regarding the handsfree role in Bluetooth/HFP. My first impression
>> looking at the source code is that some HFP functionality might be
>> missing, but I would rather have your confirmation.
>>
> Correct, in general only features that map 1:1 to existing APIs are
> exposed.  So that means network registration, voicecalls and call-volume
> interfaces.
>
>> Some examples I've found so far are the following:
>> 1. Response and hold (AT+BTRH=3D0)
>> 2. Redial last number (AT+BLDN)
>> 3. Retrieval of supported Bluetooth features for a certain modem/device
>> (AT+BRSF)
>>
> BRSF is supported and used internally, but the information is not
> exposed over D-Bus.
>
>> Could you clarify which (if any) of these features are currently
>> supported by oFono?
> Bluetooth specific features are not supported yet, these will require a
> separate atom. Roughly this means anything starting with +B.. including:
> 	- +BINP
> 	- +BLDN
> 	- +BVRA
> 	- +NREC
> 	- +BSIR
> 	- +BTRH
>
>> In general, is there any documented list of unsupported features?
>>
> In general the TODO list is your best source of readily available
> information.  In the case of HFP HF, there is no such documentation ;)
> Patches adding tasks to the TODO list to support these features are
> always welcome.
>
> Regards
> -Denis

OK, thanks for the information.

Then I guess the next question is whether you have plans to support this =

in the future, or if you would accept patches in this direction. I'm =

afraid some of them could potentially affect the existing API.

Best regards,
Mikel


--===============4311418921880107777==--

